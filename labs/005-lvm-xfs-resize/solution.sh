#!/usr/bin/env bash
set -euo pipefail

DISK="/dev/sdb"
VG="vgdata"
LV="lvapp"
LVPATH="/dev/${VG}/${LV}"
MNT="/data/app"
SIZE_INITIAL="512M"
SIZE_EXTEND="+256M"

echo "[INFO] Checking that ${DISK} exists..."
[[ -b "$DISK" ]]

echo "[INFO] Creating PV on ${DISK} if needed..."
if ! pvs "$DISK" &>/dev/null; then
  pvcreate "$DISK"
fi

echo "[INFO] Creating VG ${VG} if needed..."
if ! vgs "$VG" &>/dev/null; then
  vgcreate "$VG" "$DISK"
fi

echo "[INFO] Creating LV ${LV} if needed..."
if ! lvs "$LVPATH" &>/dev/null; then
  lvcreate -L "$SIZE_INITIAL" -n "$LV" "$VG"
fi

echo "[INFO] Creating XFS filesystem if needed..."
if ! blkid "$LVPATH" | grep -q 'TYPE="xfs"'; then
  mkfs.xfs -f "$LVPATH"
fi

echo "[INFO] Creating mount point ${MNT}..."
mkdir -p "$MNT"

UUID="$(blkid -s UUID -o value "$LVPATH")"

echo "[INFO] Ensuring /etc/fstab contains persistent mount..."
if ! grep -qE "[[:space:]]${MNT}[[:space:]]" /etc/fstab; then
  echo "UUID=${UUID} ${MNT} xfs defaults 0 0" >> /etc/fstab
fi

echo "[INFO] Mounting ${MNT}..."
mountpoint -q "$MNT" || mount "$MNT"

echo "[INFO] Extending LV by ${SIZE_EXTEND}..."
lvextend -L "$SIZE_EXTEND" "$LVPATH"

echo "[INFO] Growing XFS filesystem online..."
xfs_growfs "$MNT"

echo "[VERIFY] pvs"
pvs

echo "[VERIFY] vgs"
vgs

echo "[VERIFY] lvs"
lvs

echo "[VERIFY] findmnt ${MNT}"
findmnt "$MNT"

echo "[VERIFY] df -h ${MNT}"
df -h "$MNT"

echo "[VERIFY] grep ${MNT} /etc/fstab"
grep "$MNT" /etc/fstab

echo "[OK] Ticket 005 completed."

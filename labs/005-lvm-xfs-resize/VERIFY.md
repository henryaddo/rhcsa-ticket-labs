# Verification — Ticket 005

## Block / LVM checks
- `lsblk -f`
- `pvs`
- `vgs`
- `lvs`

## Filesystem and mount checks
- `blkid`
- `findmnt /data/app`
- `df -h /data/app`
- `mount | grep /data/app`

## Persistence checks
- `grep /data/app /etc/fstab`

## Growth checks
- `lvdisplay /dev/vgdata/lvapp`
- `xfs_info /data/app`
- `df -h /data/app`

## Screenshot Evidence
Add screenshots of:
- `pvs && vgs && lvs`
- `findmnt /data/app`
- `df -h /data/app`
- `grep /data/app /etc/fstab

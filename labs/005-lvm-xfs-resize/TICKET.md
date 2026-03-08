# Ticket 005 — Provision and Expand Application Storage (LVM + XFS)

## Business Context
The application team needs dedicated storage mounted at `/data/app`.
The storage must be managed with LVM and use XFS.
After deployment, the team requests additional space and the filesystem must be grown online.

## Requirements
1) Create a physical volume on `/dev/sdb`.
2) Create volume group `vgdata`.
3) Create logical volume `lvapp` with size `512M`.
4) Create an XFS filesystem on the logical volume.
5) Mount it at `/data/app`.
6) Ensure the mount persists across reboot using `/etc/fstab`.
7) Extend the logical volume by `256M`.
8) Grow the XFS filesystem online.
9) Verify final size and mount status.

## Constraints
- Use LVM properly.
- Use XFS.
- Do not recreate the filesystem during expansion.
- Ensure persistence with `/etc/fstab`.

## Acceptance Criteria
- `pvs`, `vgs`, and `lvs` show the expected PV/VG/LV
- `findmnt /data/app` shows the filesystem mounted
- `grep /data/app /etc/fstab` shows a persistent entry
- `lsblk -f` shows XFS on the LV
- `df -h /data/app` shows increased size after extension
- `xfs_growfs /data/app` completes successfully

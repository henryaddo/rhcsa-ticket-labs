#!/usr/bin/env bash
set -euo pipefail

DIR="/shared/ops"

echo "[INFO] Ensuring group ops exists..."
groupadd -f ops

echo "[INFO] Creating directory $DIR ..."
mkdir -p "$DIR"

echo "[INFO] Setting ownership root:ops ..."
chown root:ops "$DIR"

echo "[INFO] Setting permissions (2770 => rwx for owner/group, SGID set, no access for others) ..."
chmod 2770 "$DIR"

echo "[INFO] Setting ACL for deploy (effective now + default for new files/dirs) ..."
setfacl -m u:deploy:rwx "$DIR"
setfacl -d -m u:deploy:rwx "$DIR"

echo "[VERIFY] ls -ld $DIR"
ls -ld "$DIR"

echo "[VERIFY] getfacl $DIR"
getfacl "$DIR" | sed -n '1,120p'

echo "[INFO] Creating test file as deploy to prove write + group inheritance..."
sudo -u deploy bash -c 'echo test > /shared/ops/deploy_test.txt'

echo "[VERIFY] ls -l /shared/ops/deploy_test.txt"
ls -l /shared/ops/deploy_test.txt

echo "[VERIFY] getfacl /shared/ops/deploy_test.txt"
getfacl /shared/ops/deploy_test.txt | sed -n '1,120p'

echo "[OK] Ticket 002 completed."

#!/usr/bin/env bash
set -euo pipefail

LAB_SUDO_FILE="/etc/sudoers.d/deploy-lab"

echo "[INFO] Creating group ops (if missing)..."
groupadd -f ops

echo "[INFO] Creating user deploy (if missing)..."
if ! id deploy &>/dev/null; then
  useradd -g ops -s /bin/bash deploy
fi

echo "[INFO] Setting password for deploy (lab-only)..."
echo 'deploy:RedHat123!' | chpasswd

echo "[INFO] Writing least-privilege sudo rule..."
cat >"$LAB_SUDO_FILE" <<'SUDOEOF'
# Ticket 001 - deploy least privilege (lab)
deploy ALL=(ALL) NOPASSWD: /usr/bin/systemctl status *, /usr/bin/journalctl -xeu *
SUDOEOF

chmod 0440 "$LAB_SUDO_FILE"

echo "[INFO] Validating sudoers syntax..."
visudo -cf /etc/sudoers >/dev/null
visudo -cf "$LAB_SUDO_FILE" >/dev/null

echo "[OK] Ticket 001 completed."
echo "[VERIFY] sudo -l -U deploy"
sudo -l -U deploy

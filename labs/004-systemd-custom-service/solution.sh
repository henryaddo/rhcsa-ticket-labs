#!/usr/bin/env bash
set -euo pipefail

SCRIPT="/usr/local/bin/heartbeat.sh"
UNIT="/etc/systemd/system/heartbeat.service"
LOG="/var/log/heartbeat.log"

echo "[INFO] Creating heartbeat script..."
cat > "$SCRIPT" <<'SCRIPT_EOF'
#!/usr/bin/env bash
set -euo pipefail

LOG="/var/log/heartbeat.log"

while true; do
  echo "$(date '+%F %T') heartbeat ok" >> "$LOG"
  sleep 30
done
SCRIPT_EOF

chmod 0755 "$SCRIPT"

echo "[INFO] Creating systemd unit..."
cat > "$UNIT" <<'UNIT_EOF'
[Unit]
Description=Heartbeat writer service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/heartbeat.sh
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
UNIT_EOF

echo "[INFO] Reloading systemd..."
systemctl daemon-reload

echo "[INFO] Enabling and starting heartbeat service..."
systemctl enable --now heartbeat

echo "[VERIFY] systemctl is-active heartbeat"
systemctl is-active heartbeat

echo "[VERIFY] systemctl is-enabled heartbeat"
systemctl is-enabled heartbeat

echo "[VERIFY] systemctl status heartbeat --no-pager"
systemctl status heartbeat --no-pager || true

echo "[INFO] Waiting briefly for log entries..."
sleep 2

echo "[VERIFY] tail -n 5 $LOG"
tail -n 5 "$LOG" || true

echo "[VERIFY] journalctl -u heartbeat -n 20 --no-pager"
journalctl -u heartbeat -n 20 --no-pager || true

echo "[OK] Ticket 004 completed."

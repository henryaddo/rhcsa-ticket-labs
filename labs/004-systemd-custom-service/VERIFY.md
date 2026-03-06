# Verification — Ticket 004

## Script checks
- `ls -l /usr/local/bin/heartbeat.sh`
- `head -n 20 /usr/local/bin/heartbeat.sh`

## Service file checks
- `systemctl cat heartbeat`
- `systemctl daemon-reload`

## Service state checks
- `systemctl is-active heartbeat`
- `systemctl is-enabled heartbeat`
- `systemctl status heartbeat --no-pager`

## Logging checks
- `tail -n 5 /var/log/heartbeat.log`
- `journalctl -u heartbeat -n 20 --no-pager`

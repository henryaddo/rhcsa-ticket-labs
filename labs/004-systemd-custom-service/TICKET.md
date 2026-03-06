# Ticket 004 — Custom systemd Service

## Business Context
The operations team wants a lightweight local service that writes a heartbeat message to a log file every 30 seconds.

## Requirements
1) Create a script at `/usr/local/bin/heartbeat.sh`.
2) The script must append a timestamped message to `/var/log/heartbeat.log` every 30 seconds.
3) Create a systemd service named `heartbeat.service` to run the script.
4) Ensure the service starts now and is enabled at boot.
5) Verify the service using both `systemctl` and `journalctl`.

## Constraints
- Use systemd properly.
- Do not use cron for this task.
- The service must restart automatically if it stops.

## Acceptance Criteria
- `systemctl is-active heartbeat` returns `active`
- `systemctl is-enabled heartbeat` returns `enabled`
- `systemctl status heartbeat` shows the service running
- `/var/log/heartbeat.log` contains timestamped entries
- `journalctl -u heartbeat -n 20 --no-pager` shows service logs

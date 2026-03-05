# Verification — Ticket 003

## Package / service checks
- `rpm -q httpd`
- `systemctl is-active httpd`
- `systemctl is-enabled httpd`
- `journalctl -u httpd -n 50 --no-pager`

## SELinux checks
- `getenforce`
- `ls -Zd /web /web/content`
- `ls -Z /web/content/index.html`
- If troubleshooting: `ausearch -m avc -ts recent | tail -n 30`

## Firewall checks
- `firewall-cmd --list-services`
- `ss -tulnp | grep -E ':(80)\b'`

## Functional test
- `curl -s http://localhost/`

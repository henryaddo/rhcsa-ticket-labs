# Verification — Ticket 006

## Connection checks
- `nmcli con show`
- `nmcli con show --active`

## IP / route checks
- `ip -br a`
- `ip r`

## DNS checks
- `nmcli dev show | grep -E 'IP4.DNS|GENERAL.DEVICE'`
- `cat /etc/resolv.conf`

## Functional checks
- `ping -c 2 8.8.8.8`
- `getent hosts example.com`

## Screenshot Evidence
Add screenshots of:
- `nmcli con show`
- `ip -br a`
- `ip r`
- `nmcli dev show | grep IP4.DNS`

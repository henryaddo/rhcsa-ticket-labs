# Verification — Ticket 007

## Firewall state checks
- `systemctl is-active firewalld`
- `firewall-cmd --state`

## Zone checks
- `firewall-cmd --get-active-zones`
- `firewall-cmd --get-default-zone`

## Service / port checks
- `firewall-cmd --list-services`
- `firewall-cmd --list-ports`
- `firewall-cmd --permanent --list-services`
- `firewall-cmd --permanent --list-ports`

## Screenshot Evidence
Add screenshots of:
- `firewall-cmd --get-active-zones`
- `firewall-cmd --list-services`
- `firewall-cmd --list-ports`

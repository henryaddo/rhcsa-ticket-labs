# Ticket 007 — Allow Service Access with firewalld

## Business Context
A web service is running on the server, but users cannot reach it from the network.
The firewall must be updated to allow the required service safely and persistently.

## Requirements
1) Identify the active firewalld zone.
2) Allow the `http` service through the active zone permanently.
3) Reload firewalld to apply the change.
4) Verify that the service is allowed.
5) Add TCP port `8080` permanently as an additional application port.
6) Verify that port `8080/tcp` is allowed.

## Constraints
- Use `firewall-cmd`.
- Make changes persistent.
- Do not disable the firewall.

## Acceptance Criteria
- `firewall-cmd --get-active-zones` shows the active zone
- `firewall-cmd --list-services` includes `http`
- `firewall-cmd --list-ports` includes `8080/tcp`
- `systemctl is-active firewalld` returns `active`

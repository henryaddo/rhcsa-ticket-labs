# Ticket 003 — Apache from Non-Standard Directory (SELinux Enforcing)

## Business Context
A small internal web page must be served by Apache. The content will live in a non-standard path.

## Requirements
1) Install and start Apache (httpd).
2) Create `/web/content` and place an `index.html` file.
3) Configure Apache to use `/web/content` as the DocumentRoot.
4) SELinux must remain Enforcing; fix access properly using SELinux tools.
5) Allow inbound HTTP through the firewall.
6) Ensure Apache starts on boot.

## Constraints
- Do NOT disable SELinux.
- Use persistent SELinux fixes (not temporary).
- Use verification commands to prove the ticket is complete.

## Acceptance Criteria
- `systemctl is-active httpd` returns `active`
- `systemctl is-enabled httpd` returns `enabled`
- `getenforce` returns `Enforcing`
- `curl -s http://localhost/` returns the expected page content
- `ls -Z /web/content/index.html` shows a web-readable SELinux context type (httpd_sys_content_t)
- `firewall-cmd --list-services` includes `http`

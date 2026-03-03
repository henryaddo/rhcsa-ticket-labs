# Ticket 001 — Users, Groups, and Sudoers (Least Privilege)

## Business Context
A deployment account is needed for routine service checks. It must not have full admin access.

## Requirements
1) Create group `ops`.
2) Create user `deploy` with:
   - primary group: `ops`
   - login shell: `/bin/bash`
3) Set password for `deploy` to `RedHat123!` (lab-only).
4) Configure sudo so `deploy` can run ONLY:
   - `systemctl status *`
   - `journalctl -xeu *`
5) Sudo config must be valid and safe (no syntax errors).

## Constraints
- Do NOT grant full sudo.
- Use `/etc/sudoers.d/` (do not edit `/etc/sudoers` directly).

## Acceptance Criteria
- `id deploy` shows group `ops`
- `sudo -l -U deploy` shows only the allowed commands
- `deploy` can run `sudo systemctl status sshd` successfully
- `deploy` cannot run `sudo cat /etc/shadow`

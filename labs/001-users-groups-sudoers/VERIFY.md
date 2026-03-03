# Verification — Ticket 001

## Identity checks
- `getent group ops`
- `id deploy`

## Sudo rule checks
- `sudo -l -U deploy`
- `visudo -cf /etc/sudoers`
- `visudo -cf /etc/sudoers.d/deploy-lab`

## Functional tests
As deploy:
- `su - deploy`
- `sudo systemctl status sshd`

Negative test (should fail):
- `sudo cat /etc/shadow`

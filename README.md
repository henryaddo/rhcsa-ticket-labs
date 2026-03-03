# RHCSA Ticket Labs — RHEL 9

This project simulates real-world Linux administration tickets aligned with RHCSA EX200 objectives.

Each lab is structured like an actual support ticket:
- Clear requirements
- Security constraints
- Verification steps (acceptance tests)
- Repeatable solution script (after manual practice)

## Skills Demonstrated
- User and group administration
- Sudoers least-privilege configuration
- Linux file permissions, SGID, ACL
- SELinux context management (without disabling)
- systemd service troubleshooting (journalctl)
- LVM + XFS resizing and validation
- Networking configuration with nmcli
- Firewall configuration with firewalld

## My Support Workflow (Used in Every Ticket)
1) Understand the requirement (what “done” means)
2) Implement the change safely (least privilege, no shortcuts)
3) Verify with acceptance tests (commands + expected results)
4) Troubleshoot using a fixed checklist:
   - systemctl / journalctl
   - permissions/ownership/ACL
   - SELinux (ausearch AVC)
   - firewall (firewall-cmd, ss)
   - networking (ip, nmcli, getent)
5) Re-verify and close the ticket

## Repo Layout
Each lab contains:
- `TICKET.md` → scenario + requirements + acceptance criteria
- `VERIFY.md` → proof commands
- `solution.sh` → repeatable implementation

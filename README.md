# RHCSA Ticket Labs

A collection of hands-on Linux troubleshooting labs designed like real-world support tickets.

This repository documents my preparation for the **Red Hat Certified System Administrator (RHCSA)** exam while practicing practical system administration tasks used by Linux support engineers and system administrators.

Each lab simulates a real operations ticket and includes:

- Problem scenario
- Investigation steps
- Solution implementation
- Verification commands
- Screenshots of successful results

The goal of this project is to demonstrate **practical Linux troubleshooting skills**, not just memorizing commands.

---

# Lab Environment

- OS: RHEL-based distribution
- Environment: Virtual Machine lab
- Access method: Linux terminal (CLI)

Tools used throughout the labs:

- systemctl
- journalctl
- nmcli
- firewalld
- semanage
- setfacl / getfacl
- LVM utilities (lvcreate, vgcreate, mkfs)
- bash scripting
- standard GNU/Linux administration tools

All tasks were executed manually in the terminal to simulate real Linux administration workflows.

---

# Repository Structure

```
labs/
 ├── 001-users-groups-sudoers
 │   ├── TICKET.md
 │   ├── VERIFY.md
 │   ├── solution.sh
 │   └── screenshots/
 │
 ├── 002-permissions-acl
 ├── 003-selinux
 ├── 004-systemd-custom-service
 ├── 005-storage-lvm
 ├── 006-networking
 └── 007-firewall
```

### File Description

**TICKET.md**  
Describes the scenario and problem statement similar to a real support ticket.

**solution.sh**  
Commands used to resolve the issue.

**VERIFY.md**  
Commands used to verify that the solution works correctly.

**screenshots/**  
Terminal output showing successful implementation.

---

# Lab Index

| Ticket | Topic | Skills Practiced |
|------|------|------|
| 001 | Users, Groups, sudoers | Least-privilege access, sudo configuration |
| 002 | File Permissions & ACLs | chmod, ACL management |
| 003 | SELinux | Context troubleshooting and labeling |
| 004 | systemd | Custom service creation and management |
| 005 | Storage | LVM configuration and filesystem management |
| 006 | Networking | Interface configuration using nmcli |
| 007 | Firewall | firewalld service and port rules |

---

# Example Troubleshooting Workflow

Typical workflow used when resolving issues in these labs:

1. Identify the problem from the ticket
2. Inspect the system state using Linux tools
3. Apply the required configuration changes
4. Restart or reload affected services
5. Verify the solution using command-line validation

Example verification commands used across the labs:

```
sudo -l
systemctl status <service>
journalctl -xeu <service>
ls -l
getfacl
lsblk
nmcli connection show
firewall-cmd --list-all
```

---

# Example Real Incident Scenario

### Incident: Web Service Not Accessible

**Ticket Summary**

A user reports that a web application hosted on the server is not reachable.  
The service should be running on port **80**, but clients cannot connect.

---

### Investigation

Check if the web service is running:

```
systemctl status httpd
```

Inspect service logs:

```
journalctl -xeu httpd
```

Confirm the service is listening on port 80:

```
ss -tulpn | grep 80
```

Verify firewall rules:

```
firewall-cmd --list-all
```

Check SELinux context:

```
ls -Z /var/www/html
```

---

### Resolution

```
systemctl start httpd
systemctl enable httpd

firewall-cmd --add-service=http --permanent
firewall-cmd --reload
```

---

### Verification

```
systemctl status httpd
ss -tulpn | grep 80
curl http://localhost
```

Successful verification confirms the web service is operational.

---

# Linux Troubleshooting Toolkit

Common commands used during Linux troubleshooting:

```
systemctl
journalctl
ss
ip
nmcli
lsblk
df
mount
top
ps
firewall-cmd
semanage
restorecon
```

These tools are essential for diagnosing system, network, storage, and service issues.

---

# Skills Demonstrated

This repository demonstrates practical Linux system administration skills including:

- Linux user and group management
- Privilege delegation with sudo
- File permissions and ACL configuration
- SELinux troubleshooting
- systemd service management
- Storage administration using LVM
- Networking configuration with nmcli
- Firewall configuration using firewalld
- Bash scripting for troubleshooting tasks

---

# Purpose of This Project

This project was created to:

- Practice **RHCSA-level administration tasks**
- Develop **real Linux troubleshooting habits**
- Build a **portfolio demonstrating hands-on Linux skills**

Instead of isolated command practice, each lab focuses on **real operational scenarios** similar to issues handled by Linux support engineers.

---

# About

Created by **Henry Addo**

Aspiring Linux System Administrator preparing for the **RHCSA certification**.

This repository is part of my learning journey to develop practical Linux administration and troubleshooting skills.
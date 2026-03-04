# Ticket 002 — Shared Directory (SGID + ACL)

## Business Context
The ops team needs a shared directory where team members can collaborate.
The directory must be secure: "others" must have no access.

## Requirements
1) Create directory: `/shared/ops`.
2) Ownership:
   - owner: `root`
   - group: `ops`
3) Permissions:
   - group must have rwx
   - others must have no permissions
   - SGID must be set so new files inherit group `ops`
4) ACL:
   - user `deploy` must always have rwx on the directory
   - default ACL must ensure new files/dirs also grant `deploy` rwx
5) Create a test file as `deploy` in `/shared/ops` to prove inheritance.

## Constraints
- Do NOT make it world-writable.
- Use SGID and ACL correctly.

## Acceptance Criteria
- `ls -ld /shared/ops` shows `drwxrws---` (or equivalent with SGID) and group `ops`
- `getfacl /shared/ops` shows ACL for `deploy` and default ACL for `deploy`
- A file created by `deploy` inside `/shared/ops` has group `ops`
- `deploy` can write into `/shared/ops` even if not owner

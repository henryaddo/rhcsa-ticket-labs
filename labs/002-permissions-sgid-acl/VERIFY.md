# Verification — Ticket 002

## Directory checks
- `ls -ld /shared/ops`
- `getfacl /shared/ops`

## SGID inheritance test
As deploy:
- `sudo -u deploy bash -c 'echo test > /shared/ops/deploy_test.txt; ls -l /shared/ops/deploy_test.txt'`

Expected:
- file group is `ops`

## ACL default inheritance check
- `getfacl /shared/ops/deploy_test.txt`

Expected:
- `user:deploy:rw-` (or rwx depending on file/umask)

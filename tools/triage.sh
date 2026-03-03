#!/usr/bin/env bash
set -euo pipefail

svc="${1:-}"

echo "== TRIAGE SNAPSHOT =="
echo "[TIME] $(date)"
echo

echo "== Failed systemd units (top) =="
systemctl --failed --no-pager || true
echo

if [[ -n "$svc" ]]; then
  echo "== Service: $svc (status) =="
  systemctl status "$svc" --no-pager || true
  echo

  echo "== Service: $svc (recent logs) =="
  journalctl -u "$svc" -n 50 --no-pager || true
  echo
fi

echo "== SELinux =="
getenforce || true
echo

echo "== Recent SELinux AVC denials (if any) =="
ausearch -m avc -ts recent 2>/dev/null | tail -n 30 || echo "(no ausearch output or audit logs unavailable)"
echo

echo "== Listening ports =="
ss -tulnp 2>/dev/null | head -n 25 || true
echo

echo "== Firewall (active zones + services) =="
firewall-cmd --get-active-zones 2>/dev/null || echo "(firewalld not running)"
firewall-cmd --list-services 2>/dev/null || true
echo

echo "== Networking (quick) =="
ip -br a || true
echo
ip r || true
echo

echo "== DNS quick test (if network available) =="
getent hosts example.com || echo "(DNS lookup failed or no network)"
echo

echo "[OK] triage complete."
echo "Usage: tools/triage.sh [service]"


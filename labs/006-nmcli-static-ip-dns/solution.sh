#!/usr/bin/env bash
set -euo pipefail

IPADDR_CIDR="192.168.122.50/24"
GATEWAY="192.168.122.1"
DNS="8.8.8.8"

echo "[INFO] Detecting active NetworkManager connection..."
CON_NAME="$(nmcli -t -f NAME con show --active | head -n1)"

if [[ -z "${CON_NAME}" ]]; then
  echo "[ERROR] No active NetworkManager connection found."
  exit 1
fi

echo "[INFO] Active connection detected: ${CON_NAME}"

echo "[INFO] Configuring static IPv4 settings..."
nmcli con mod "${CON_NAME}" ipv4.addresses "${IPADDR_CIDR}"
nmcli con mod "${CON_NAME}" ipv4.gateway "${GATEWAY}"
nmcli con mod "${CON_NAME}" ipv4.dns "${DNS}"
nmcli con mod "${CON_NAME}" ipv4.method manual

echo "[INFO] Bringing connection up..."
nmcli con up "${CON_NAME}"

echo "[VERIFY] nmcli con show --active"
nmcli con show --active

echo "[VERIFY] ip -br a"
ip -br a

echo "[VERIFY] ip r"
ip r

echo "[VERIFY] nmcli dev show | grep -E 'IP4.DNS|GENERAL.DEVICE'"
nmcli dev show | grep -E 'IP4.DNS|GENERAL.DEVICE' || true

echo "[VERIFY] cat /etc/resolv.conf"
cat /etc/resolv.conf || true

echo "[OK] Ticket 006 completed."

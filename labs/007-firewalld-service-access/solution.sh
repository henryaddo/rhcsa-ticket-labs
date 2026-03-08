#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Ensuring firewalld is installed..."
dnf -y install firewalld >/dev/null

echo "[INFO] Enabling and starting firewalld..."
systemctl enable --now firewalld

echo "[INFO] Detecting active zone..."
ACTIVE_ZONE="$(firewall-cmd --get-active-zones | awk 'NR==1{print $1}')"

if [[ -z "${ACTIVE_ZONE}" ]]; then
  echo "[ERROR] Could not detect an active firewalld zone."
  exit 1
fi

echo "[INFO] Active zone: ${ACTIVE_ZONE}"

echo "[INFO] Adding http service permanently..."
firewall-cmd --permanent --zone="${ACTIVE_ZONE}" --add-service=http >/dev/null

echo "[INFO] Adding port 8080/tcp permanently..."
firewall-cmd --permanent --zone="${ACTIVE_ZONE}" --add-port=8080/tcp >/dev/null

echo "[INFO] Reloading firewalld..."
firewall-cmd --reload >/dev/null

echo "[VERIFY] systemctl is-active firewalld"
systemctl is-active firewalld

echo "[VERIFY] firewall-cmd --get-active-zones"
firewall-cmd --get-active-zones

echo "[VERIFY] firewall-cmd --list-services"
firewall-cmd --list-services

echo "[VERIFY] firewall-cmd --list-ports"
firewall-cmd --list-ports

echo "[OK] Ticket 007 completed."

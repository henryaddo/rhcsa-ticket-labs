#!/usr/bin/env bash
set -euo pipefail

DOCROOT="/web/content"
HTTPD_CONF="/etc/httpd/conf/httpd.conf"

echo "[INFO] Installing required packages..."
dnf -y install httpd policycoreutils-python-utils >/dev/null

echo "[INFO] Creating DocumentRoot and content..."
mkdir -p "$DOCROOT"
cat >"$DOCROOT/index.html" <<'HTML'
<!doctype html>
<html>
  <head><meta charset="utf-8"><title>Ticket 003</title></head>
  <body><h1>OK - served from /web/content</h1></body>
</html>
HTML

echo "[INFO] Backing up Apache config (if not already backed up)..."
if [[ ! -f "${HTTPD_CONF}.bak.ticket003" ]]; then
  cp -a "$HTTPD_CONF" "${HTTPD_CONF}.bak.ticket003"
fi

echo "[INFO] Updating Apache DocumentRoot and Directory block..."
# Replace DocumentRoot line
sed -i 's#^DocumentRoot ".*"#DocumentRoot "/web/content"#' "$HTTPD_CONF"

# Update the <Directory "..."> block that matches the old docroot (usually "/var/www")
# This is intentionally simple for lab purposes.
sed -i 's#^<Directory ".*">#<Directory "/web/content">#' "$HTTPD_CONF"

echo "[INFO] Applying SELinux context rules for web content (persistent)..."
semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
restorecon -Rv /web >/dev/null

echo "[INFO] Enabling and starting httpd..."
systemctl enable --now httpd

echo "[INFO] Opening firewall for HTTP..."
firewall-cmd --permanent --add-service=http >/dev/null
firewall-cmd --reload >/dev/null

echo "[VERIFY] systemctl is-active httpd"
systemctl is-active httpd

echo "[VERIFY] getenforce"
getenforce

echo "[VERIFY] ls -Z ${DOCROOT}/index.html"
ls -Z "${DOCROOT}/index.html"

echo "[VERIFY] firewall-cmd --list-services"
firewall-cmd --list-services

echo "[VERIFY] curl http://localhost/"
curl -s http://localhost/ | head -n 5

echo "[OK] Ticket 003 completed."

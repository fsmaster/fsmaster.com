#!/usr/bin/env bash
#
# Redeploy the fsmaster.com static site on the host-nginx node.
# Usage (on the server, from a clone of this repo):
#     ./deploy/deploy.sh
#
# It syncs public/ into the nginx web root and reloads nginx.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WEBROOT="${WEBROOT:-/var/www/fsmaster}"

echo "Deploying $REPO_DIR/public -> $WEBROOT"
mkdir -p "$WEBROOT"
rsync -a --delete "$REPO_DIR/public/" "$WEBROOT/"
chown -R www-data:www-data "$WEBROOT"

# Optional: (re)install the nginx vhost if it is missing.
if [ ! -e /etc/nginx/sites-enabled/fsmaster ]; then
  echo "Installing nginx vhost"
  cp "$REPO_DIR/deploy/fsmaster.nginx" /etc/nginx/sites-available/fsmaster
  ln -sf /etc/nginx/sites-available/fsmaster /etc/nginx/sites-enabled/fsmaster
fi

nginx -t
systemctl reload nginx
echo "Done — https://fsmaster.com is updated."

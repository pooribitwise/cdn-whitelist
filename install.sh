#!/bin/bash

echo "Starting Installation..."

mkdir -p /opt/cdn_ips_whitelist

curl -s -o /opt/cdn_ips_whitelist/cdn-updater.sh https://raw.githubusercontent.com/pooribitwise/cdn-whitelist/refs/heads/main/src/cdn-updater.sh
chmod +x /opt/cdn_ips_whitelist/cdn-updater.sh


echo "Adding systemd service and timer..."

cat <<EOF > /etc/systemd/system/cdn-updater.service
[Unit]
Description=Update CDN IP lists for Firewalld
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/opt/cdn_ips_whitelist/cdn-updater.sh
EOF

cat <<EOF > /etc/systemd/system/cdn-updater.timer
[Unit]
Description=Run CDN Updater Script Daily

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
EOF

systemctl daemon-reload
systemctl enable --now cdn-updater.timer
# run for the first time right now
systemctl start cdn-updater.service

echo "Installation completed successfully!"


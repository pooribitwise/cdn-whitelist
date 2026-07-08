#!/bin/bash

echo "Downloading CDN IP lists..."

curl -s https://www.cloudflare.com/ips-v4 > /tmp/cdn-ips.txt
echo '' >> /tmp/cdn-ips.txt
curl -s https://www.arvancloud.ir/en/ips.txt >> /tmp/cdn-ips.txt

sudo firewall-cmd --permanent --new-ipset=cdn-ips --type=hash:net 2>/dev/null

echo "Adding IPs to Firewalld..."
sudo firewall-cmd --permanent --ipset=cdn-ips --add-entries-from-file=/tmp/cdn-ips.txt

sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source ipset="cdn-ips" port port="80" protocol="tcp" accept'
sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source ipset="cdn-ips" port port="443" protocol="tcp" accept'

sudo firewall-cmd --reload
rm -f /tmp/cdn-ips.txt

echo "CDN IPs updated successfully!"

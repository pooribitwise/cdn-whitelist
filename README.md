# CDN Whitelisting script

---
## Introduction
This script whitelists Cloudflare's & AbrArvan's CDN IPs to firewalld (RHEL equivilant of ufw).
The IPs are obtained from the main sources and updated daily.

---
## Usage
1. Download the project file:
```bash
git clone https://github.com/pooribitwise/cdn-whitelist.git && cd cdn-whitelist
```
2. Make the install script executable:
```bash
chmod +x install.sh
```
3. Run the script as root:
```bash
sudo ./install.sh
```
4. Check if everything's fine:
```bash
# must show dead and exited successfully
systemctl status cdn-updater.service

# must show the example:
#rule family="ipv4" source ipset="cdn-ips" port port="80" protocol="tcp" accept
#rule family="ipv4" source ipset="cdn-ips" port port="443" protocol="tcp" accept
sudo firewall-cmd --list-rich-rules
# ensure there is no rule whitelisting 80,443 ports and http,https services
sudo firewall-cmd --list-services && sudo firewall-cmd --list-ports

# check if it is scheculed in systemd.timer:
systemctl list-timers | grep cdn-updater.timer
```

---
## License
GPL v2.0

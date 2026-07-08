# CDN Whitelisting script

---
## Introduction
This script whitelists Cloudflare's & AbrArvan's CDN IPs to firewalld (RHEL equivilant of ufw).
The IPs are obtained from the main sources and updated daily.

---
## Usage
1. Run installing script:
```bash
curl https://raw.githubusercontent.com/pooribitwise/cdn-whitelist/refs/heads/main/install.sh | sudo sh
```

2. Check if everything's fine:
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

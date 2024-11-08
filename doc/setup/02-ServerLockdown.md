### Prerequisites

- ssh key added to server for root user
- Backup of your ssh private key in a safe place \
  __Without backup, you may lose access to your server if your laptop is stolen or breaks__

### Steps

#### 1. Install package updates
```bash
apt update
apt upgrade
```


#### 2. Bare minimum
```bash
ssh root@railsguru.dev

# Disallow password authentication
sudo vim /etc/ssh/sshd_config
# IF YOU HAVE YOUR SSH KEY ADDED set the following:
PasswordAuthentication no

service ssh restart

# Enable firewall
ufw allow ssh
ufw allow 443/tcp
ufw default deny incoming
ufw enable
ufw status
```

#### 3. Advanced
```bash
ssh root@railsguru.dev

# Enable fail2ban
apt install fail2ban
systemctl enable fail2ban
systemctl start fail2ban
```
#!/bin/bash

echo 'root:Riedel1!' | chpasswd
echo 'pi:Riedel1!' | chpasswd

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
systemctl enable ssh
systemctl start ssh

echo "alias ls='ls -al --color=auto'" >> /home/pi/.profile
echo "alias ls='ls -al --color=auto'" >> /root/.profile

echo 'MAILTO=""' | crontab -

#apt-get -y upgrade

apt-get install -y openocd

apt install -y ntp
systemctl enable ntp

timedatectl set-local-rtc true
timedatectl set-timezone Europe/Berlin

# install a webserver
apt-get install -y nginx
wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add -
echo "deb https://packages.sury.org/php/ stretch main" | sudo tee /etc/apt/sources.list.d/php.list
apt-get update
apt-get install -y php5.6-fpm
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default-backup
cp /opt/testfarm/config/default /etc/nginx/sites-available/default
rm -rf /var/www/html
mkdir /var/www/public


# it is up to the caller to do a reboot!

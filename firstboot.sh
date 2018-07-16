#!/bin/bash
echo 'root:Riedel1!' | chpasswd
echo 'pi:Riedel1!' | chpasswd

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
systemctl enable ssh
systemctl start ssh

echo "alias ls='ls -al --color=auto'" >> /home/pi/.profile
echo "alias ls='ls -al --color=auto'" >> /root/.profile

echo 'MAILTO=""' | crontab -

#apt-get -y update
#apt-get -y upgrade

apt-get install -y openocd

apt install -y ntp
systemctl enable ntp

timedatectl set-local-rtc true
timedatectl set-timezone Europe/Berlin

mkdir /opt/testfarm/scripts

# it is up to the caller to do a reboot!

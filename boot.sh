#!/bin/bash

TARGET="/opt/testfarm"
ENDPOINT="http://manufacturing.riedel.net/files/testfarm"

cd $TARGET
cronscript=$TARGET/watchdog.sh

if [ ! -d $TARGET/log ]; then
   mkdir $TARGET/log
   $TARGET/firstboot.sh
   reboot
fi

# remove old watchdog -v = reverse -w wildcard
crontab -l | grep -v -w "watchdog.sh" | crontab -

# install watchdog in cron
(crontab -l 2>/dev/null; echo "*/1 * * * * $cronscript") | crontab -

timedatectl set-ntp 1

curl "$ENDPOINT/scripts/device-register.py" > $TARGET/scripts/device-register.py
python3 $TARGET/scripts/device-register.py

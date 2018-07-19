#!/bin/bash

TARGET="/opt/testfarm"
ENDPOINT="http://manufacturing.riedel.net/files/testfarm"

if [ ! -d $TARGET/log ]; then
   mkdir $TARGET/log
   chmod +x $TARGET/firstboot.sh
   $TARGET/firstboot.sh
   reboot
fi

cd $TARGET

# download repo, and make sure only repo is there
# revoke local changes
git fetch --all
git reset --hard origin/master


# remove old watchdog -v = reverse -w wildcard, and install a new one
cronscript=$TARGET/watchdog.sh
crontab -l | grep -v -w "watchdog.sh" | crontab -

# install watchdog in cron
(crontab -l 2>/dev/null; echo "*/1 * * * * $cronscript") | crontab -

timedatectl set-ntp 1

curl "$ENDPOINT/scripts/device-register.py" > $TARGET/scripts/device-register.py
python3 $TARGET/scripts/device-register.py

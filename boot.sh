#!/bin/bash

# the repo needs the have 3 files hardcoded:
# - this file (boot.sh)
# - bootscript.sh => is run once on a vergin device
# - scripts/device-register.py => is run after boot to register the device in the portal

TARGET="/opt/testfarm"

if [ ! -d $TARGET/log ]; then
   mkdir $TARGET/log
   chmod +x $TARGET/firstboot.sh
   . $TARGET/firstboot.sh
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

# register our device with the portal
python3 $TARGET/scripts/device-register.py

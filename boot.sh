#!/bin/bash

# the repo needs the have 3 files hardcoded:
# - this file (boot.sh)
# - bootscript.sh => is run once on a virgin device
# - scripts/device-register.py => is run after boot to register the device in the portal

TARGET="/opt/testfarm"
LOG=$TARGET"/log/boot.log"
FIRSTBLOG=$TARGET"/log/firstboot.log"

if [ ! -d $TARGET/log ]; then
   mkdir $TARGET/log
   echo 'executing firstboot.sh' > $FIRSTBLOG
   chmod +x $TARGET/firstboot.sh
   . $TARGET/firstboot.sh >> $FIRSTBLOG
   reboot
else
   echo 'executing boot, firstboot already done' > $LOG
fi
 
cd $TARGET

#wait for the wlan to connect, maximum of 60 seconds
COUNTER=0
while [ $COUNTER -lt 60 ]; do
  if [ $(ip addr show wlan0 | grep inet | wc -l) -ne 0 ]; then
     echo 'wlan0 is up ..' >> $LOG
     break
  fi
  sleep 1
  let COUNTER=COUNTER+1
  echo 'waiting for wlan0 ..' >> $LOG
done

# download repo, and make sure only repo is there
# revoke local changes. 
# note, the reset wit revoke all local changes. This makes debuging cumbersome. So check if bittbucket is active
git ls-remote &>-
if [ "$?" -ne 0  ]; then
   echo 'fetching repo ..' >> $LOG
   git fetch --all
   git reset --hard origin/master
else
   echo 'no connection to repo, skipping fetch ..' >> $LOG
fi 
chmod +x *.sh

# update website of Pi
echo 'installing pi control panel ..' >> $LOG
yes | cp -rf $TARGET/www/* /var/www/public &> /dev/null
rm -fR $TARGET/www &> /dev/null

# remove old watchdog -v = reverse -w wildcard, and install a new one
echo 'installing watchdog ..' >> $LOG
cronscript=$TARGET/watchdog.sh
crontab -l | grep -v -w "watchdog.sh" | crontab -

# install watchdog in cron
(crontab -l 2>/dev/null; echo "*/1 * * * * $cronscript") | crontab -

timedatectl set-ntp 1 

# register our device with the portal
echo 'registering device to portal ..' >> $LOG
python3 $TARGET/scripts/device-register.py > $TARGET/log/device-register.log

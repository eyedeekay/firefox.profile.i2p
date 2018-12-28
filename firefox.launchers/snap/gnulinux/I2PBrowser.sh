#! /usr/bin/env bash

if [ ! -z "$SUDO_USER" ]; then
    BR_USER=$SUDO_USER
else
    BR_USER=$USER
fi

export DIR="/home/$BR_USER/.mozilla/firefox/firefox.profile.i2p"

PRENUM=$(/bin/grep '\[Profile' /home/$(who am i | awk '{print $1}')/.mozilla/firefox/profiles.ini | tail -n 1 | tr -d 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]')
NUM=$(($PRENUM + 1))

echo "
[Profile$NUM]
Name=I2PBrowser-Launcher
IsRelative=1
Path=firefox.profile.i2p
" >> /home/$(who am i | awk '{print $1}')/.mozilla/firefox/profiles.ini

"$SNAP/usr/lib/firefox.profile.i2p/install.sh" install
"$SNAP/usr/lib/firefox.profile.i2p/install.sh" run

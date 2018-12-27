#! /usr/bin/env bash

if [ ! -z "$SUDO_USER" ]; then
    BR_USER=$SUDO_USER
else
    BR_USER=$USER
fi

export DIR="/home/$BR_USER/.mozilla/firefox/firefox.profile.i2p"

"$SNAP/usr/lib/firefox.profile.i2p/install.sh" install
"$SNAP/usr/lib/firefox.profile.i2p/install.sh" run

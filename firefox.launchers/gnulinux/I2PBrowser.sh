#! /usr/bin/env bash

if [ "$USER" = "root" ]; then
    exit "Browsers should definitely not run as root!"
fi

export DIR="$HOME/.mozilla/firefox/firefox.profile.i2p"

if [ ! -d "$HOME/.mozilla/firefox/" ]; then
    mkdir -p "$SNAP_USER_COMMON/.config"
    firefox -screenshot test.jpg  https://developer.mozilla.com && killall firefox
fi

PRENUM=$(/bin/grep '\[Profile' $HOME/.mozilla/firefox/profiles.ini | tail -n 1 | tr -d 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]')
NUM=$(($PRENUM + 1))

echo "
[Profile$NUM]
Name=I2PBrowser-Launcher
IsRelative=1
Path=firefox.profile.i2p
" >> $HOME/.mozilla/firefox/profiles.ini

"$SNAP/usr/lib/firefox.profile.i2p/install.sh" install
"$SNAP/usr/lib/firefox.profile.i2p/install.sh" run

#! /usr/bin/env bash

if [ "$USER" = "root" ]; then
    exit "Browsers should definitely not run as root!"
fi

export DIR="$HOME/.mozilla/firefox/firefox.profile.i2p"

if [ ! -d "$HOME/.mozilla/firefox/" ]; then
    mkdir -p "$SNAP_USER_COMMON/.config"
    firefox -screenshot test.jpg  https://developer.mozilla.com && killall firefox
fi

"$SNAP/usr/lib/firefox.profile.i2p/install.sh" install
"$SNAP/usr/lib/firefox.profile.i2p/install.sh" private

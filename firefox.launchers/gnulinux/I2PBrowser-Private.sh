#! /usr/bin/env bash

if [ "$USER" = "root" ]; then
    exit "Browsers should definitely not run as root!"
fi

export DIR="$HOME/.mozilla/firefox/firefox.profile.i2p"

"$SNAP/usr/lib/firefox.profile.i2p/install.sh" install
"$SNAP/usr/lib/firefox.profile.i2p/install.sh" private

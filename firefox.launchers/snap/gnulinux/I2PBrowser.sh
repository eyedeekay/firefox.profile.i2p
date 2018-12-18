#! /usr/bin/env bash

DIR=$(who am i | awk '{print $1}')/.mozilla/firefox/firefox.profile.i2p

"$DIR/install.sh" install
"$DIR/install.sh" run

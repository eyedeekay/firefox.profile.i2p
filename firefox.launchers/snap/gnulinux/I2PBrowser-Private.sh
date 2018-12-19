#! /usr/bin/env bash

export DIR=/home/$(who am i | awk '{print $1}')/.mozilla/firefox/firefox.profile.i2p

"/usr/lib/firefox.profile.i2p/install.sh" install
"/usr/lib/firefox.profile.i2p/install.sh" private

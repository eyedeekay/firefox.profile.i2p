#! /usr/bin/env bash

DIR=$(who am i | awk '{print $1}')/.i2pbrowser/

"/usr/lib/firefox.profile.i2p/install.sh" install
"/usr/lib/firefox.profile.i2p/install.sh" private

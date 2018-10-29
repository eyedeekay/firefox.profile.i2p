#! /usr/bin/env bash

####                                                                        ####
#                                                                              #
#  This installer will set up a Firefox profile, desktop launcher, and an      #
#  optional bash_alias for launching from the terminal, configured to browse   #
#  i2p. It does this in the user's home directory, and does not require root.  #
#                                                                              #
####                                                                        ####

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

TITLE="i2p Browser Profile Set-Up"

ME=$(whoami)

TOR=$(which torsocks)

if [ "x$ME" = "xroot" ]; then
    USER_HOME="/home/$SUDO_USER"
else
    USER_HOME="$HOME"
fi

USAGE="
####                                                                        ####
#                                                                              #
#  This installer will set up a Firefox profile, desktop launcher, and an      #
#  optional bash_alias for launching from the terminal, configured to browse   #
#  i2p. It does this in the user's home directory, and does not require root.  #
#                                                                              #
####                                                                        ####

The installation will take place in $USER_HOME

    usage:
       ./install.sh install     # install the profile and browser launcher
       ./install.sh uninstall   # remove the profile and browser launcher
       ./install.sh alias       # configure a .bash_alias to launch the browser
       ./install.sh usage       # show this usage message
       ./install.sh run         # run from this directory without installing
"

usage(){
    echo "$USAGE"
}

update(){
    mv "$DIR/firefox.profile.i2p/" "$DIR/.firefox.profile.i2p.bak/"
    if [ "x$TOR" != "x" ]; then
        echo "$TOR detected, updates will be retrieved over Tor"
    fi
    $TOR curl -L https://github.com/eyedeekay/firefox.profile.i2p/releases/download/current/i2pbrowser-profile-update.zip --output i2pbrowser-profile-update.zip
    sleep 1
    unzip i2pbrowser-profile-update.zip
    rm -rf "$DIR/.firefox.profile.i2p.bak/" i2pbrowser-profile-update.zip
}

install(){
    mkdir -pv "$USER_HOME/.mozilla/firefox/"
    cp -rv "$DIR/firefox.profile.i2p" "$USER_HOME/.mozilla/firefox/firefox.profile.i2p"
    cp -v i2pbrowser-firefox.desktop \
		"$USER_HOME/.local/share/applications/i2pbrowser-firefox.desktop"
    cp -v i2pbrowser-firefox-private.desktop \
		"$USER_HOME/.local/share/applications/i2pbrowser-firefox-private.desktop"
}

uninstall(){
    rm -fv "$USER_HOME/.local/share/applications/i2pbrowser-firefox.desktop" \
        "$USER_HOME/.local/share/applications/i2pbrowser-firefox-private.desktop"
}

run(){
    rm -rfv "$DIR/.firefox.profile.i2p"
    cp -rv "$DIR/firefox.profile.i2p" "$DIR/.firefox.profile.i2p"
    firefox --no-remote --profile "$DIR/.firefox.profile.i2p" --private about:config
    rm -rfv "$DIR/.firefox.profile.i2p"
}

if [ "x$1" = "x" ]; then
    usage
else
    "$1"
fi

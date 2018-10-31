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

UPDATE_URL=https://github.com/eyedeekay/firefox.profile.i2p/releases/download/current/i2pbrowser-profile-update.zip

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
       ./install.sh update      # update the profile from $UPDATE_URL
       ./install.sh run         # run from this directory without installing
            firefox --no-remote --profile \"\$DIR/.firefox.profile.i2p.default\" about:blank \$1
       ./install.sh private     # run in private mode from this directory without installing
            firefox --no-remote --profile \"\$DIR/.firefox.profile.i2p.private\" --private about:blank \$1
       ./install.sh debug       # run with debugger from this directory without installing
            firefox --jsconsole --devtools --no-remote --profile \"\$DIR/.firefox.profile.i2p.debug\" --private about:blank \$1

"

usage(){
    echo "$USAGE"
}

update(){
    mv "$DIR/firefox.profile.i2p/" "$DIR/.firefox.profile.i2p.bak/"
    if [ "x$TOR" != "x" ]; then
        echo "$TOR detected, updates will be retrieved over Tor"
    fi
    $TOR curl -L "$UPDATE_URL" --output i2pbrowser-profile-update.zip
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

debug(){
    rm -rfv "$DIR/.firefox.profile.i2p.debug"
    cp -rv "$DIR/firefox.profile.i2p" "$DIR/.firefox.profile.i2p.debug"
    firefox --jsconsole --devtools --no-remote --profile "$DIR/.firefox.profile.i2p.debug" --private about:blank $1
    rm -rfv "$DIR/.firefox.profile.i2p.debug"
}

private(){
    rm -rfv "$DIR/.firefox.profile.i2p.private"
    cp -rv "$DIR/firefox.profile.i2p" "$DIR/.firefox.profile.i2p.private"
    firefox --no-remote --profile "$DIR/.firefox.profile.i2p.private" --private about:blank $1
    rm -rfv "$DIR/.firefox.profile.i2p.private"
}

run(){
    if [ ! -d "$DIR/.firefox.profile.i2p.default" ]; then
        cp -rv "$DIR/firefox.profile.i2p" "$DIR/.firefox.profile.i2p.default"
    fi
    firefox --no-remote --profile "$DIR/.firefox.profile.i2p.default" about:blank $1
}

if [ "x$1" = "x" ]; then
    usage
else
    "$1" $2
fi

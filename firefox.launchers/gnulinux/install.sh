#! /usr/bin/env bash

####                                                                        ####
#                                                                              #
#  This installer will set up a Firefox profile, desktop launcher, and an      #
#  optional bash_alias for launching from the terminal, configured to browse   #
#  i2p. It does this in the user's home directory, and does not require root.  #
#                                                                              #
####                                                                        ####

if [ "$DIR" = "" ]; then
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
fi
TITLE="i2p Browser Profile Set-Up"

ME=$(whoami)

TOR=$(which torsocks)
EEP=$(which eepget)

if [ "x$ME" = "xroot" ]; then
    USER_HOME="/home/$SUDO_USER"
else
    USER_HOME="$HOME"
fi

if [ "x$EEP" = "x" ]; then
    UPDATE_URL=https://github.com/eyedeekay/firefox.profile.i2p/releases/download/current/i2pbrowser-profile-update.zip
    DL_COMMAND="$TOR curl -L $UPDATE_URL --output i2pbrowser-profile-update.zip"
    DL_COMMAND_SUM="$TOR curl -L $UPDATE_URL.sha256sum --output i2pbrowser-profile-update.zip.sha256sum"
    DL_COMMAND_SIG="$TOR curl -L $UPDATE_URL.sha256sum.asc --output i2pbrowser-profile-update.zip.sha256sum.asc"
else
    if [ "x$EEP_UPDATE_PATH" = "x" ]; then
        EEP_UPDATE_PATH="ihcrgsnj2vh5zb7lvatwko3nwm3kiltcy7n3yu7zitgijrbl6rhq.b32.i2p"
    fi
    UPDATE_URL="http://$EEP_UPDATE_PATH/i2pbrowser-profile-update.zip"
    DL_COMMAND="$EEP -o i2pbrowser-profile-update.zip $UPDATE_URL"
    DL_COMMAND_SUM="$EEP -o i2pbrowser-profile-update.zip.sha256sum $UPDATE_URL.sha256sum"
    DL_COMMAND_SIG="$EEP -o i2pbrowser-profile-update.zip.sha256sum.asc $UPDATE_URL.sha256sum.asc"
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
    if [ "x$EEP" != "x" ]; then
        echo "$EEP detected, updates will be retrieved over i2p"
    elif [ "x$TOR" != "x" ]; then
        echo "$TOR detected, updates will be retrieved over Tor"
    fi
    $DL_COMMAND
    $DL_COMMAND_SUM
    $DL_COMMAND_SIG
    sleep 1
    sha256sum -c i2pbrowser-profile-update.zip.sha256sum
    gpg --keyid-format long --verify i2pbrowser-profile-update.zip.sha256sum.asc i2pbrowser-profile-update.zip.sha256sum
    unzip i2pbrowser-profile-update.zip
    rm -rf "$DIR/.firefox.profile.i2p.bak/" i2pbrowser-profile-update.zip
}

install(){
    if [ ! -d "$USER_HOME/.mozilla/firefox/firefox.profile.i2p" ]; then
        mkdir -pv "$USER_HOME/.mozilla/firefox/"
        echo "Installing to $USER_HOME"
        if [ -d /usr/lib/firefox.profile.i2p/ ]; then
            cp -rv "/usr/lib/firefox.profile.i2p" "$USER_HOME/.mozilla/firefox/firefox.profile.i2p"
            cp -v "/usr/lib/firefox.profile.i2p/i2pbrowser-firefox.desktop" \
                "$USER_HOME/.local/share/applications/i2pbrowser-firefox.desktop"
            cp -v "/usr/lib/firefox.profile.i2p/i2pbrowser-firefox-private.desktop" \
                "$USER_HOME/.local/share/applications/i2pbrowser-firefox-private.desktop"
        else
            cp -rv "$DIR/" "$USER_HOME/.mozilla/firefox/firefox.profile.i2p"
            cp -v "$DIR/i2pbrowser-firefox.desktop" \
                "$USER_HOME/.local/share/applications/i2pbrowser-firefox.desktop"
            cp -v "$DIR/i2pbrowser-firefox-private.desktop" \
                "$USER_HOME/.local/share/applications/i2pbrowser-firefox-private.desktop"
        fi
    fi
}

uninstall(){
    rm -fv "$USER_HOME/.local/share/applications/i2pbrowser-firefox.desktop" \
        "$USER_HOME/.local/share/applications/i2pbrowser-firefox-private.desktop"
}

debug(){
    echo "$DIR" | grep '/usr/lib/firefox.profile.i2p' && \
    DIR="$USER_HOME"
    rm -rfv "$DIR/.firefox.profile.i2p.debug"
    cp -rv "$DIR/firefox.profile.i2p" "$DIR/.firefox.profile.i2p.debug"
    firefox --jsconsole --devtools --no-remote --profile "$DIR/.firefox.profile.i2p.debug" --private about:blank $1
    rm -rfv "$DIR/.firefox.profile.i2p.debug"
}

private(){
    echo "$DIR" | grep '/usr/lib/firefox.profile.i2p' && \
    DIR="$USER_HOME"
    rm -rfv "$DIR/.firefox.profile.i2p.private"
    cp -rv "$DIR/firefox.profile.i2p" "$DIR/.firefox.profile.i2p.private"
    firefox --no-remote --profile "$DIR/.firefox.profile.i2p.private" --private about:blank $1
    rm -rfv "$DIR/.firefox.profile.i2p.private"
}

run(){
    echo "$DIR" | grep '/usr/lib/firefox.profile.i2p' && \
    DIR="$USER_HOME"
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

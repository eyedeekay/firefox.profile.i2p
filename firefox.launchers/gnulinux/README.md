
### Automatic Setup [Standalone guide](LINUX.md) (Debian, Ubuntu, apt-based with Firefox-ESR)

A pre-built deb(for now, crudely generated with checkinstall) is able to
configure an i2p browser on Debian-based distributions as long as they
package Firefox, NoScript, and HTTPS-Everywhere. This deb simply configures
system-firefox with alternate defaults and configures launchers to use them
with. Note that in this configuration, Firefox will also have the system plugins
installed in Debian.

  0. Download the i2pbrowser-helper .deb package from the [releases page](https://github.com/eyedeekay/firefox.profile.i2p/releases).
  1. Double-click the newly downloaded .deb file and install it.
  2. Run I2PBrowser.sh and/or I2PBrowser-Private.sh to launch Firefox with the
  i2p browsing profile.

        #! /bin/sh
        wget -c https://github.com/eyedeekay/firefox.profile.i2p/releases/download/0.04/i2pbrowser-helper_all.deb
        sudo apt-get install ./i2pbrowser-helper_all.deb

### Building a .deb with Checkinstall

If you don't want to trust the deb I generated, then it's also very simple to
generate your own from this source code.

  1. Install git, make, and checkinstall
  2. Clone this repository and change to the newly created directory
  3. run 'make debfirefox'
  4. Install the generated
  package.

        # /bin/sh
        sudo apt-get install git make checkinstall
        git clone https://github.com/eyedeekay/firefox.profile.i2p && cd firefox.profile.i2p
        make debfirefox
        i2pbrowser-helper_all.deb
        sudo apt-get install ./i2pbrowser-helper_all.deb

### Snap Setup [Standalone guide](LINUX.md) (Cross-Distribution)

The latest snap can be installed from edge and has desktop shortcuts.
[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/i2pbrowser)

  1. Open a terminal and run: 'snap install --edge i2pbrowser'
  2. Run the shortcut from your application menu or /snap/bin/i2pbrowser from a
  terminal.

        #! /bin/sh
        snap install --edge i2pbrowser
        /snap/bin/i2pbrowser

It's not likely that integrating a snap with Tor Browser will be possible unless
Tor Browser becomes available as a snap, which seems unlikely. I can think of
some things that *might* work but none are... perfectly clear to me.
Auto-updating of the profile via the install script isn't possible in the snap,
*but* snapcraft.io seems to get updates about ~9 minutes after this repository
does. That means a s simple 'snapcraft refresh --edge i2pbrowser' will
automatically update the profile for you.

### Make Setup [Standalone guide](LINUX.md) (Cross-Distribution)

  1. Install the firefox-esr browser from your distribution or from Mozilla's
    web site. Be sure to place it into your PATH as firefox, for example,
    /usr/bin/firefox.
  2. Download the GNU/Linux zip bundle from the releases page and unpack it.
  3. Run the following make
  targets:

        #! /bin/sh
        make recopy-linux
        sudo make install

When it's done, you can run 'I2PBrowser.sh' to start the i2p browser profile.

### Docker Setup [Standalone guide](LINUX.md) (Linux, probably OSX, Windows?)

Linux and Mac OSX users can run the browser within a Docker container. This
image uses an entirely un-official upstream image of the Tor Browser Bundle
from Dockerhub, also authored by me. Should you wish to build it yourself,
instructions can be found below. However, if you wish to run the i2p Browser
from the Docker Hub and have i2p installed on the host, you may simply:

        docker run --rm -i -t \
            -e DISPLAY=:0 \
            --net host \
            --name i2p-browser \
            --volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
            eyedeekay/firefox.profile.i2p

To launch a Tor Browser configured with this profile from the terminal.

In order to examine or build the upstream package locally, see:
[eyedeekay/tbb-docker](https://github.com/eyedeekay/tbb-docker).

If you have trouble connecting the Dockerized application to the X server, you
may need to authorize the Docker user to access the X server.

        xhost +"local:docker@"

### Manual Setup (Various Linuxes) [Standalone guide](LINUX.md) (Debian-Derived distros see Footnote #2)

*NOTE: I'm probably going to add an apparmor profile to this setup for optional*
*installation.*

  0. Install Firefox-ESR via the method preferred by your Linux distribution.
  1. Download the i2pbrowser-gnulinux.zip from here. If you prefer, an identical
  i2pbrowser-gnulinux.tar.gz is also available.
  2. Extract it.
  3. Run ./install.sh install from within the extracted folder. Alternatively,
  run ./install.sh run to run entirely from within the current directory.

If you want to just copy-paste some commands into your terminal, you could:

        #! /bin/sh
        curl https://github.com/eyedeekay/firefox.profile.i2p/releases/download/current/i2pbrowser-gnulinux.tar.gz --output i2pbrowser-gnulinux.tar.gz
        tar xvzf i2pbrowser-gnulinux.tar.gz
        cd i2pbrowser-gnulinux
        ./install.sh install

Once you've run "./install.sh install" you can safely delete the profile folder
if you wish. Alternatively, you could choose to run from the downloaded profile
directory by running "./install.sh run" or "./install.sh private" instead. This
will always start in Private Browsing mode, and if you delete the download
folder, you will need to re-download it to run the browser from the directory
again.

Here's some more information about how to use the install script:

        usage:
            ./install.sh install     # install the profile and browser launcher
            ./install.sh uninstall   # remove the profile and browser launcher
            ./install.sh alias       # configure a .bash_alias to launch the browser
            ./install.sh usage       # show this usage message
            ./install.sh update      # update the profile
            ./install.sh run         # run from this directory without installing
                firefox --no-remote --profile "$DIR/.firefox.profile.i2p.default" about:blank $1
            ./install.sh private     # run in private mode from this directory without installing
                firefox --no-remote --profile "$DIR/.firefox.profile.i2p.private" --private about:blank $1
            ./install.sh debug       # run with debugger from this directory without installing
                firefox --jsconsole --devtools --no-remote --profile "$DIR/.firefox.profile.i2p.debug" --private about:blank $1

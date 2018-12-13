# firefox.profile.i2p

Much of this is ready for interested parties to test, but it's still just being
tested and the rough edges are still being figured out. Use at your own risk.

For now, the testing release page is here: [Github Releases](https://github.com/eyedeekay/firefox.profile.i2p/releases/tag/current)
where the Windows installer has been made available. The "current" release will
always track the newest working version. Numbered releases are the latest
version that I'm testing. There's not really a coherent rationale to the
version numbers yet. I move them when I add a feature to make sure I know what
to uninstall. Roughly, that corresponds to a "Feature." That is the only purpose
they serve for the moment.

## What it is

This is a profile for Firefox, pre-configured to use i2p, with an accompanying
launcher for easy use. It also comes pre-configured to disable certain features
that may weaken the anonymity that i2p provides, and with NoScript and HTTPS
Everywhere.

For more information, see: [DETAILS.md](DETAILS.md)

### Automatic Setup (Recommended, Windows) [Standalone guide](WINDOWS.md)

  0. Install the Firefox web browser. You can download it from
    [Mozilla's web site](https://www.mozilla.org/en-US/firefox/new/).
    *Alternatively, if you're using the latest testing version of the profile,*
    *it will use a Tor Browser if one is found in a default location,* which you
    can get from the [Tor Browser Bundle download page](https://www.torproject.org/projects/torbrowser.html.en).
    This may provide additional security.
  1. Download the i2p Firefox profile installer, install-i2pbrowser.exe, from
    [This releases page](https://github.com/eyedeekay/firefox.profile.i2p/releases/download/current/install-i2pbrowser.exe)
    and run it. If Firefox was not detected in the default location, then you
    will be offered a menu to select it in a custom location.
  2. To start Firefox with the i2p Browsing profile, click the shortcut to
    "I2PBrowser-Launcher" or "Private Browsing-I2PBrowser-Launcher" from your
    Start Menu or your Desktop.

### Run-From-Zip (Alternative, Windows)

  0. Install the Firefox web browser. You can download it from
    [Mozilla's web site](https://www.mozilla.org/en-US/firefox/new/). The
    browser *must* be installed in a default location selected by the Firefox
    installer for this to work. This version does work with Tor Browser yet.
  1. Download the i2p Firefox profile zip bundle, i2pbrowser-windows-0.04.zip, from
    [This releases page](https://github.com/eyedeekay/firefox.profile.i2p/releases/download/current/i2pbrowser-windows-0.04.zip)
  2. To start Firefox with the i2p Browsing profile, double-click the
    i2pbrower.bat script.

### Manual Setup (OSX) [Standalone guide](MACOSX.md)

  0.
  1.
  2.
  3.

### Docker Setup [Standalone guide](LINUX.md) (Linux, probably OSX and possibly Windows?)

Linux and Mac OSX users can run the browser within a Docker container. This
image uses an entirely un-official upstream image of the Tor Browser Bundle
from Dockerhub, also authored by me. Should you wish to build it yourself,
instructions can be found below. However, if you wish to run the i2p Browser
from the Docker Hub and have i2p installed on the host, you may simply:

```sh
docker run --rm -i -t -d \
	-e DISPLAY=:0 \
	--net host \
	--name i2p-browser \
	--volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
    eyedeekay/firefox.profile.i2p
```

To launch a Tor Browser configured with this profile from the terminal.

In order to examine or build the upstream package locally, see:
[eyedeekay/tbb-docker](https://github.com/eyedeekay/tbb-docker).

If you have trouble connecting the Dockerized application to the X server, you
may need to authorize the Docker user to access the X server.

```sh
xhost +"local:docker@"
```

### Manual Setup (Various Linuxes) [Standalone guide](LINUX.md) (Debian-Derived distros see Footnote #2)

*NOTE: I'm probably going to add an apparmor profile to this setup for optional*
*installation.*

  0. Install Firefox-ESR via the method preferred by your Linux distribution.
  1. Download the i2pbrowser-gnulinux-0.04.zip from here. If you prefer, an identical
  i2pbrowser-gnulinux-0.04.tar.gz is also available.
  2. Extract it.
  3. Run ./install.sh install from within the extracted folder. Alternatively,
  run ./install.sh run to run entirely from within the current directory.

If you want to just copy-paste some commands into your terminal, you could:

```sh
curl https://github.com/eyedeekay/firefox.profile.i2p/releases/download/current/i2pbrowser-gnulinux-0.04.tar.gz --output i2pbrowser-gnulinux-0.04.tar.gz
tar xvzf i2pbrowser-gnulinux-0.04.tar.gz
cd i2pbrowser-gnulinux
./install.sh install
```

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

#### Screenshots

  * **check.kovri.i2p:**

![Figure D: check.kovri.i2p results](images/firefox.profile.i2p.png)

  * **valve/fingerprintjs**

![Figure E: Browser Fingerprint](images/firefox.profile.i2p.fingerprint.png)

#### Footnotes [Download these notes](NOTES.md)

##### Differences from Tor Browser

TL:DR There is no security slider, and to compensate for this issue, the Browser
is configured to enable fewer features by default. It also can't do stuff like
notify you about your browser window size.

This browser takes cues from the Tor Browser, which is also a reasonable choice
for an i2p browser, but it has some absolutely critical differences from the Tor
Browser which will probably not come into play, but which you should be aware
of. First, there is no Torbutton, which means that this browser lacks the coarse
global controls of sensitive browser features that the Torbutton provides to the
Tor Browser Bundle. In order to deal with this issue the default NoScript
configuration is more restrictive.
##### Debian/Ubuntu users can use Whonix stretch-testng i2p browser launcher

If you are using Debian or Ubuntu, or probably any other up-to-date apt-based
Linux distribution, there's another option which may you may prefer. In order to
do this, one must add the Whonix apt package repository to your package sources,
and install their tb-starter package from their stretch-testing repository.
Don't worry, I'll take you through it step-by-step.

**This guide is intended for users who are aware of the implications of using**
**third-party repositories on their Debian-based Linux PC's.** In particular,
Whonix is designed to pro-actively prevent certain kinds of attacks from
affecting the user, and their packages sometimes overwrite things like hosts
files and such with versions suitable for the Whonix threat model. While I
currently use the following packages successfully on both Debian and Ubuntu
Linux at this time, I cannot guarantee that they will work for everyone's
specific configuration.

First, you'll need to obtain and install the Whonix package signing keys. This
will allow you to be sure that you are obtaining the correct package from the
repository automatically.

```sh
sudo apt-key --keyring /etc/apt/trusted.gpg.d/whonix.gpg adv --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-keys 916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA
```

Next, you need to tell apt, the package manager, where to look for the packages
in question. The i2p browser is still in stretch-testers, so that is the version
we will be using. 'main' means that the profile is Free Software per the Debian
Free Software Guidelines.

```sh
echo 'deb http://deb.whonix.org stretch-testers main' | tee /etc/apt/sources.list.d/whonix-testing.list # apt-transport-* season to taste
```

Now, you must tell apt to update it's list of available packages so it becomes
aware of the Tor Browser packages.

```sh
sudo apt-get update
```

Finally, install tb-starter and tb-updater.

```sh
sudo apt-get install tb-starter
```

The last step is to run update-i2pbrowser. This will pre-configure the i2p
browser on your system.

```sh
update-i2pbrowser
```

If for some reason, update-i2pbrowser doesn't work(Usually this is in the
absence of Tor on the system) you may run

```sh
update-i2pbrowser --devbuildpassthrough
```

instead.

Finally, you need to add the following lines to the bottom of
/etc/i2pbrowser.d/31\_i2p\_default.conf.

        TOR_HIDE_UPDATE_CHECK_UI=1
        TOR_NO_DISPLAY_NETWORK_SETTINGS=1
        TOR_HIDE_BROWSER_LOGO=1
        TOR_SKIP_LAUNCH=1
        TOR_SKIP_CONTROLPORTTEST=1

Or, you can just run these commands, now that you know what they do:

        sudo apt-key --keyring /etc/apt/trusted.gpg.d/whonix.gpg adv --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-keys 916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA
        echo 'deb http://deb.whonix.org stretch-testers main' | tee /etc/apt/sources.list.d/whonix-testing.list # apt-transport-* season to taste
        sudo apt-get update
        sudo apt-get install tb-starter
        update-i2pbrowser

Browser Security Testing:
=========================

  * **master:** 3dpwhxxcp47t7h6pnejm5hw7ymv56ywee3zdhct2sbctubsb3yra.b32.i2p

  * **fingerprinter:** qsagwif55g5gxsnka6r5ewuna6gokme2nv64s4zofl4hhuuqnd4q.b32.i2p



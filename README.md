# firefox.profile.i2p

Much of this is ready for interested parties to test, but it's still just being
tested and the rough edges are still being figured out. Use at your own risk.

For now, the testing release page is here: [Github Releases](https://github.com/eyedeekay/firefox.profile.i2p/releases/tag/current)
where the Windows installer has been made available. The "current" release will
always track the newest working version. Numbered releases are the latest
version that I'm testing.

## What it is

This is a profile for Firefox, pre-configured to use i2p, with an accompanying
launcher for easy use. It also comes pre-configured to disable certain features
that may weaken the anonymity that i2p provides, and with NoScript and HTTPS
Everywhere.

For more information, see: [DETAILS.md](DETAILS.md)

### Automatic Setup (Recommended, Windows) [Standalone guide](WINDOWS.md)

  0. Install the Firefox web browser. You can download it from
    [Mozilla's web site](https://www.mozilla.org/en-US/firefox/new/).
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
    installer for this to work.
  1. Download the i2p Firefox profile zip bundle, i2pbrowser-windows-0.02a.zip, from
    [This releases page](https://github.com/eyedeekay/firefox.profile.i2p/releases/download/current/i2pbrowser-windows-0.02a.zip)
  2. To start Firefox with the i2p Browsing profile, double-click the
    i2pbrower.bat script.

### Manual Setup (OSX) [Standalone guide](MACOSX.md)

  0.
  1.
  2.
  3.

### Manual Setup (Various Linuxes) [Standalone guide](LINUX.md) (Debian-Derived distros see Footnote #2)

*NOTE: I'm probably going to add an apparmor profile to this setup for optional*
*installation.*

  0. Install Firefox-ESR via the method preferred by your Linux distribution.
  1. Download the i2pbrowser-gnulinux-0.02a.zip from here. If you prefer, an identical
  i2pbrowser-gnulinux-0.02a.tar.gz is also available.
  2. Extract it.
  3. Run ./install.sh install from within the extracted folder. Alternatively,
  run ./install.sh run to run entirely from within the current directory.

If you want to just copy-paste some commands into your terminal, you could:

```sh
curl https://github.com/eyedeekay/firefox.profile.i2p/releases/download/current/i2pbrowser-gnulinux-0.02a.tar.gz --output i2pbrowser-gnulinux-0.02a.tar.gz
tar xvzf i2pbrowser-gnulinux-0.02a.tar.gz
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

```sh
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
```

#### Screenshots

  * **check.kovri.i2p:**

![Figure D: check.kovri.i2p results](images/firefox.profile.i2p.png)

  * **valve/fingerprintjs**

![Figure E: Browser Fingerprint](images/firefox.profile.i2p.fingerprint.png)

#### Footnotes

##### Differences from Tor Browser

TL:DR There is no security slider, and to compensate for this issue, the Browser
is configured to enable fewer features by default.

This browser takes cues from the Tor Browser, which is also a reasonable choice
for an i2p browser, but it has some absolutely critical differences from the Tor
Browser which will probably not come into play, but which you should be aware
of. First, there is no Torbutton, which means that this browser lacks the coarse
global controls of sensitive browser features that the Torbutton provides to the
Tor Browser Bundle. In order to deal with this issue the default NoScript
configuration is more restrictive.

##### Debian/Ubuntu users

If you are using Debian or Ubuntu, or probably any other up-to-date apt-based
Linux distribution, there's another option which may you may prefer. In order to
do this, one must add the Whonix apt package repository to your package sources,
and install their tb-starter package from their stretch-testing repository.
Don't worry, I'll take you through it step-by-step.

Or, you can just run these commands, now that you know what they do:

```sh
sudo apt-key --keyring /etc/apt/trusted.gpg.d/whonix.gpg adv --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-keys 916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA
echo 'deb http://deb.whonix.org stretch-testers main' | tee /etc/apt/sources.list.d/whonix-testing.list # apt-transport-* season to taste
sudo apt-get update
sudo apt-get install tb-starter
```

Browser Security Testing:
=========================

  * **master:** 3dpwhxxcp47t7h6pnejm5hw7ymv56ywee3zdhct2sbctubsb3yra.b32.i2p

  * **fingerprinter:** qsagwif55g5gxsnka6r5ewuna6gokme2nv64s4zofl4hhuuqnd4q.b32.i2p


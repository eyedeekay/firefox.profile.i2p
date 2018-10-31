
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

```sh
curl https://github.com/eyedeekay/firefox.profile.i2p/releases/download/current/i2pbrowser-gnulinux.tar.gz --output i2pbrowser-gnulinux.tar.gz
tar xvzf i2pbrowser-gnulinux.tar.gz
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

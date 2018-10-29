
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
curl --output i2pbrowser-gnulinux.tar.gz
tar xvzf i2pbrowser-gnulinux.tar.gz
cd i2pbrowser-gnulinux
./install.sh install
```

Once you've run "./install.sh install" you can safely delete the profile folder
if you wish. Alternatively, you could choose to run from the downloaded profile
directory by running "./install.sh run" instead. This will always start in
Private Browsing mode, and if you delete the download folder, you will need to
re-download it to run the browser from the directory again.

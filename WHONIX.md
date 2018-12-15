
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
sudo apt-get install tb-starter tb-updater
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
        sudo apt-get install tb-starter tb-updater
        update-i2pbrowser

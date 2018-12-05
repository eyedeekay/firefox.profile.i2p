
#### Screenshots

  * **check.kovri.i2p:**

![Figure D: check.kovri.i2p results](images/firefox.profile.i2p.png)

  * **valve/fingerprintjs**

![Figure E: Browser Fingerprint](images/firefox.profile.i2p.fingerprint.png)

#### Footnotes

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

##### Debian/Ubuntu users

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

Or, you can just run these commands, now that you know what they do:

```sh
sudo apt-key --keyring /etc/apt/trusted.gpg.d/whonix.gpg adv --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-keys 916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA
echo 'deb http://deb.whonix.org stretch-testers main' | tee /etc/apt/sources.list.d/whonix-testing.list # apt-transport-* season to taste
sudo apt-get update
sudo apt-get install tb-starter
update-i2pbrowser
```

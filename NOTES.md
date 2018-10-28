
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

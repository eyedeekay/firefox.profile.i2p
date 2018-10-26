# firefox.profile.i2p

## Importable firefox profile for use with i2p

### Contents

This repository contains two things:

  * A Firefox Profile for use with i2p
  * A launcher to ensure that it is used properly with i2p

### Manual Setup

  0. Install Firefox on your platform.
  1. Download the profile release bundle from here. It is a zip file, which
  contains the profile we will be using with Firefox for our i2p-based browsing.

#### Footnotes

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

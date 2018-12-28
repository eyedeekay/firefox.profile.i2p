# firefox.profile.i2p

[![Snap Status](https://build.snapcraft.io/badge/eyedeekay/firefox.profile.i2p.svg)](https://build.snapcraft.io/user/eyedeekay/firefox.profile.i2p)
[![Travis-CI .dmg Status](https://travis-ci.com/eyedeekay/firefox.profile.i2p.svg?branch=master)](https://travis-ci.com/eyedeekay/firefox.profile.i2p)

Much of this is ready for interested parties to test, but it's still just being
tested and the rough edges are still being figured out. Use at your own risk.

For now, the testing release page is here: [Github Releases](https://github.com/eyedeekay/firefox.profile.i2p/releases/tag/current)
where the Windows installer has been made available. The "current" release will
always track the newest working version. Numbered releases are the latest
version that I'm testing. There's not really a coherent rationale to the
version numbers yet. I move them when I add a feature to make sure I know what
to uninstall. Roughly, that corresponds to a "Feature." That is the only purpose
they serve for the moment.

## Coarse Changelog/Roadmap

  - Current == 0.4
  - 0.x Intitial configuration,
  - 0.01x Wrapper-launcher for Windows/Firefox, Whonix browser for Debian Derivs
  - 0.02x Improved Reliability
  - 0.03x Reddit to-do list, i2prouter integration, Tor Browser Bundle
    integration for Windows
  - 0.04x Additional packaging, snap, dmg, deb metapackage
  - 0.05x (Planned) Tor Browser Bundle integration for OSX, torbrowser-launcher
    integration for Linux, Internationalization
  - 0.06x (Planned) Finalize packaging, User-readiness, automate fingerprint
    measurements, automate hostile testing.
  - 0.07x (Planned) Control Plugin, additional plugin evaluation(Font fingerprint
    mitigations? Perhaps an "Expert Bundle" with uMatrix?)
  - 0.08x (Planned) Android port, build-from-source
  - 0.09x (Planned) Selenium-based browser tests, Update services
  - 0.10x (Planned) No known bugs. Best-case scenario for current i2p browsers
    using Firefox or TBB.

## What it is

This is a profile for Firefox, pre-configured to use i2p, with an accompanying
launcher for easy use. It also comes pre-configured to disable certain features
that may weaken the anonymity that i2p provides, and with NoScript and HTTPS
Everywhere.

For more information, see: [DETAILS.md](DETAILS.md)

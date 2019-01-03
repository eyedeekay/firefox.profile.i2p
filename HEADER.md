# firefox.profile.i2p

[![Snap Status](https://build.snapcraft.io/badge/eyedeekay/firefox.profile.i2p.svg)](https://build.snapcraft.io/user/eyedeekay/firefox.profile.i2p)
[![Travis-CI .dmg Status](https://travis-ci.com/eyedeekay/firefox.profile.i2p.svg?branch=master)](https://travis-ci.com/eyedeekay/firefox.profile.i2p)

[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/i2pbrowser)

## What it is

This is a set of tools for major Desktop computing platforms(Windows, Mac OSX,
and Linux) which automatically configures a Firefox browser for use with i2p. It
attempts to minimize the amount of user interaction that is required to get the
browser up and running correctly. It requires an i2p router and either a Firefox
or Tor Browser to run.

To the end of simplicity, it attempts to make use of standard, familiar
installation procedures for each of these platforms. The Windows package is just
a regular installer.exe/uninstaller.exe pair. You download either Firefox or the
Tor Browser Bundle and install it first. Then you
[download the installer from the github releases](https://github.com/eyedeekay/firefox.profile.i2p/releases/download/current/install-i2pbrowser.exe),
and run it. It will place two items on the start menu and two shortcuts on the
desktop, any of which will launch a browser pre-configured to use i2p.

On OSX, the goal is to create a .dmg application image but I'm stalled here for
the moment while I wait for more access to an OSX machine.

On GNU/Linux it's more of a collection of tools for a variety of package
managers. Ubuntu users will probably find the snap package most convenient.
It just bundles Firefox and the scripts that make sure the configuration is
correct together in their little snap package and runs it from inside the
container. There are also a variety of other options for other platforms.

What it configures is a profile for Firefox, set up to use i2p, with an
accompanying launcher for easy use. It also comes pre-configured to disable
certain features that may weaken the anonymity that i2p provides, and with
NoScript and HTTPS Everywhere.

For more information, see: [DETAILS.md](DETAILS.md)

Much of this is ready for interested parties to test, but it's still just being
tested and the rough edges are still being figured out. Use at your own risk.

For now, the testing release page is here: [Github Releases](https://github.com/eyedeekay/firefox.profile.i2p/releases/tag/current)
where the Windows installer has been made available. The "current" release will
always track the newest working version. Numbered releases are the latest
version that I'm testing. There's not really a coherent rationale to the
version numbers yet. I move them when I add a feature to make sure I know what
to uninstall.

  * [Source Code:](https://github.com/eyedeekay/firefox.profile.i2p)

## Coarse Changelog/Roadmap

  - Current == 0.05
  - 0.x Intitial configuration,
  - 0.01x Wrapper-launcher for Windows/Firefox, Whonix browser for Debian Derivs
  - 0.02x Improved Reliability
  - 0.03x Reddit to-do list, i2prouter integration, Tor Browser Bundle
    integration for Windows
  - 0.04x Additional packaging, snap, dmg, deb metapackage
  - 0.05x Tor Browser Bundle integration for OSX, torbrowser-launcher
    integration for Linux, Internationalization
  - 0.06x (Planned) Finalize packaging, User-readiness, automate fingerprint
    measurements, automate hostile testing.
  - 0.07x (Planned) Control Plugin, additional plugin evaluation(Font fingerprint
    mitigations? Perhaps an "Expert Bundle" with uMatrix?)
  - 0.08x (Planned) Android port, build-from-source
  - 0.09x (Planned) Selenium-based browser tests, Update services
  - 0.10x (Planned) No known bugs. Best-case scenario for current i2p browsers
    using Firefox or TBB.

### Donate

  * XMR:43V6cTZrUfAb9JD6Dmn3vjdT9XxLbiE27D1kaoehb359ACaHs8191mR4RsJH7hGjRTiAoSwFQAVdsCBToXXPAqTMDdP2bZB
  * BTC:159M8MEUwhTzE9RXmcZxtigKaEjgfwRbHt

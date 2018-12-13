Whonix Tor Browser helper for Debian-based distributions:
=========================================================

In order to use the i2p Browser from Whonix on a regular Debian or Ubuntu
distribution, you need to create a configuration file at /etc/i2pbrowser.d/90\_i2p\_browser\_debian.conf
containing the following:

```sh
TOR_HIDE_UPDATE_CHECK_UI=1
TOR_NO_DISPLAY_NETWORK_SETTINGS=1
TOR_HIDE_BROWSER_LOGO=1
TOR_SKIP_LAUNCH=1
TOR_SKIP_CONTROLPORTTEST=1
```

This will install it automatically.

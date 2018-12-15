What is this package
====================

This package contains exactly one file, a configuration file specific to the
Whonix I2P Browser when running on a non-Whonix system. These settings guarantee
that Tor-specific features will not be checked when the browser is launched,
specifically, it will not launch Tor, check for a control port, or display Tor
specific UI features. This settings file will be installed at

        /etc/i2pbrowser.d/90_i2p_browser_debian.conf

and it contains the lines:

        TOR_HIDE_UPDATE_CHECK_UI=1
        TOR_NO_DISPLAY_NETWORK_SETTINGS=1
        TOR_HIDE_BROWSER_LOGO=1
        TOR_SKIP_LAUNCH=1
        TOR_SKIP_CONTROLPORTTEST=1

Besides that, it acts as a metapackage for installing the Whonix Tor Browser
management packages tb-starter, tb-updater, and open-link-confirmation as well
as their dependencies.

It should only change if the way Whonix packages it's Tor Browser Launcher
scripts changes considerably. Building and installing it with Checkinstall just
once will likely be sufficient for the foreseeable future. Your updates will
come from the respective upstream projects, Whonix and Tor Browser Bundle, who
have nothing to do with this repo or this package.

What is this repo:
==================

This is an apt repository in a github page in a git repository containing one
package that will probably not need to be updated for a very long time. If you
would prefer not to use checkinstall, it is also available, but it does mean
that you're giving me root. Potentially anybody who can steal my keys too. So
that would be a bummer if that were to happen. However, since it won't be
updated often and is by-definition never going to be urgent, it might be
acceptable to pin it at a specific version or simply disable updates by
commenting out the sources.list file after it is installed. It might also be
worth it to think about ways to guarantee that the package can't be tampered
with, it's literally the simplest possible thing in the world for lots of people
to build and hash all at once.

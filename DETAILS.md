# Information you deserve to have if you're looking for it.

## Differences from Tor Browser Bundle

When using Vanilla firefox, many of Tor Browser's fingerprinting mitigations
will have partial functionality. Screen-size fingerprinting, for instance. If
you need to protect against this kind of fingerprinting, then you
should modify a Tor Browser Bundle to use i2p.

## Use of Tor Browser Bundle

The testing version of the Windows installer integrates with the Tor Browser
Bundle if it's presently installed on the computer. If not, it defaults to using
Firefox with the modified profile instead. This enables more complete
protection than regular Firefox.

However, it will *never touch files belonging to a user's installed Tor Browser*
*except to copy them completely, and only where absolutely necessary.* The whole
point is to separate contextual identities.

## Relentless self-criticism

This inherits features from TBB and is certainly considerably better than
nothing, in fact, it's probably pretty good. But I haven't formally modeled a
threat here, and I didn't document my process as well as I should have. I simply
focused on building something that would work. This document is part of an
overall effort to rectify that situation, document how this is superior to
simply modifying proxy settings or editing the about:config of an existing
Firefox profile in the non-obvious ways.

## extensions

### HTTPS Everywhere

Because of i2p's self-authenticating nature and the fact that most eepsites do
not utilize https by default yet, HTTPS Everywhere is largely inert for now. It
is included, with modified proxy settings to use the i2p network, to facilitate
those few that currently do and those that choose to in the future.

These are the modified settings used for HTTPS Everywhere:

        user_pref("extensions.https_everywhere._observatory.enabled", false);
        user_pref("extensions.https_everywhere.options.autoUpdateRulesets", false);
        user_pref("extensions.https_everywhere.globalEnabled", false);
        user_pref("extensions.https_everywhere._observatory.submit_during_tor", false);
        user_pref("extensions.https_everywhere._observatory.submit_during_nontor", false);
        user_pref("extensions.https_everywhere._observatory.use_custom_proxy", true);
        user_pref("extensions.https_everywhere._observatory.proxy_host", "127.0.0.1");
        user_pref("extensions.https_everywhere._observatory.proxy_port", 4444);

### NoScript

NoScript is included for the obvious reason that Javascript is code from
internet strangers that you allow to be run on your computer. It is set up with
the defaults from the Tor Browser Bundle, partly because in the TBB NoScript
does not update automatically and there's no place to update from inside of i2p
yet. That probably needs to be worked on.

Besides Tor Browser's NoScript Settings, Flash, Silverlight, Java and other
plugins are completely disabled instead of Click-To-Play.

These are the modified settings used for NoScript:

        # In order to disable all scripts by default, uncomment the following line...
        # user_pref("capability.policy.maonoscript.javascript.enabled", "noAccess");
        # and comment out the following line
        user_pref("capability.policy.maonoscript.javascript.enabled", "allAccess");
        user_pref("capability.policy.maonoscript.sites", "[System+Principal] about: about:tbupdate about:tor chrome: resource: blob: mediasource: moz-extension: moz-safe-about: about:neterror about:certerror about:feeds about:tabcrashed about:cache");
        user_pref("noscript.default", "[System+Principal] about: about:tbupdate about:tor chrome: resource: blob: mediasource: moz-extension: moz-safe-about: about:neterror about:certerror about:feeds about:tabcrashed about:cache");
        user_pref("noscript.mandatory", "[System+Principal] about: about:tbupdate about:tor chrome: resource: blob: mediasource: moz-extension: moz-safe-about: about:neterror about:certerror about:feeds about:tabcrashed about:cache");
        user_pref("noscript.ABE.enabled", false);
        user_pref("noscript.ABE.notify", false);
        user_pref("noscript.ABE.wanIpAsLocal", false);
        user_pref("noscript.confirmUnblock", false);
        user_pref("noscript.contentBlocker", true);
        user_pref("noscript.firstRunRedirection", false);
        user_pref("noscript.global", true);
        user_pref("noscript.gtemp", "");
        user_pref("noscript.opacizeObject", 3);
        user_pref("noscript.forbidWebGL", true);
        user_pref("noscript.forbidFonts", true);
        user_pref("noscript.options.tabSelectedIndexes", "5,0,0");
        user_pref("noscript.policynames", "");
        user_pref("noscript.secureCookies", true);
        user_pref("noscript.showAllowPage", false);
        user_pref("noscript.showBaseDomain", false);
        user_pref("noscript.showDistrust", false);
        user_pref("noscript.showRecentlyBlocked", false);
        user_pref("noscript.showTemp", false);
        user_pref("noscript.showTempToPerm", false);
        user_pref("noscript.showUntrusted", false);
        user_pref("noscript.STS.enabled", false);
        user_pref("noscript.subscription.lastCheck", -142148139);
        user_pref("noscript.temp", "");
        user_pref("noscript.untrusted", "");
        user_pref("noscript.forbidMedia", true);
        user_pref("noscript.allowWhitelistUpdates", false);
        user_pref("noscript.fixLinks", false);

These settings differ from the Tor Browser Bundle, but were left in their
original position in the file because it makes diffing things nicer.

        // Now handled by plugins.click_to_play //Not in this one.
        user_pref("noscript.forbidFlash", true);
        user_pref("noscript.forbidSilverlight", true);
        user_pref("noscript.forbidJava", true);
        user_pref("noscript.forbidPlugins", true);


Now another section identical to the corresponding Tor Browser section.

        // Usability tweaks
        user_pref("noscript.showPermanent", false);
        user_pref("noscript.showTempAllowPage", true);
        user_pref("noscript.showRevokeTemp", true);
        user_pref("noscript.notify", false);
        user_pref("noscript.autoReload", true);
        user_pref("noscript.autoReload.allTabs", false);
        user_pref("noscript.cascadePermissions", true);
        user_pref("noscript.restrictSubdocScripting", true);
        user_pref("noscript.showVolatilePrivatePermissionsToggle", false);
        user_pref("noscript.volatilePrivatePermissions", true);
        user_pref("noscript.clearClick", 0);

For now, NoScript was chosen(Pretty much unilaterally, by me) because it was the
one used in Tor Browser Bundle and I figure inherit the benefits of their fine
work. Since targeting TBB's fingerprint exactly isn't really a reasonable goal
here, after all, we won't be coming out of an exit node so we'll never look like
Tor in the most obvious way, uMatrix presents an interesting possibility.

## user.js

Beyond the plugins, the user.js(which is the file that contains the individual
about:config settings) enables several security enhancements and disables
several privacy risks.

### Enable Uplift benefits

From the Tor Browser's "Uplift" effort we enable privacy.resistFingerprint and
privacy.firstparty.isolate.

        user_pref("privacy.resistFingerprinting", true);
        user_pref("privacy.firstparty.isolate", true);

        // Use i2p http proxy for all connections and set homepage to safe local form.

### Set i2p proxy, disable access to local services(Including Admin Panel)

Obviously, we set the proxy. In this case, we use the http proxy for all ports
*and* set share proxy settings. Also set the homepage to about:blank and
disallow access to any unproxied hosts, including the localhost. This is because
someone could potentially attempt to load a resource from a service running on
your computer via an eepsite in order to weaken your anonymity.

        // DON'T allow access to the admin panel from the profile we browse i2p with.
        user_pref("network.proxy.no_proxies_on", 0);
        user_pref("network.proxy.type", 1);
        user_pref("network.proxy.http", "127.0.0.1");
        user_pref("network.proxy.http_port", 4444);
        user_pref("network.proxy.ssl", "127.0.0.1");
        user_pref("network.proxy.ssl_port", 4444);
        user_pref("network.proxy.ftp", "127.0.0.1");
        user_pref("network.proxy.ftp_port", 4444);
        user_pref("network.proxy.socks", "127.0.0.1");
        user_pref("network.proxy.socks_port", 4444);
        user_pref("network.proxy.share_proxy_settings", true);
        user_pref("browser.startup.homepage", "about:blank");

In Tor Browser mode, it's also necessary to enable the use of a non-Tor proxy,
disable the launching of the Tor Browser's included Tor proxy, and disable the
prompt to configure the Tor Network at the launch of the Tor Browser.

        user_pref("extensions.torbutton.use_nontor_proxy", true);
        user_pref("extensions.torlauncher.start_tor", false);
        user_pref("extensions.torlauncher.prompt_at_startup", false);

### Section Three: Various sources, mostly Tor Browser discussions, Mozilla Wiki, and privacytools.io

Also this awesomely useful resource: https://github.com/pyllyukko/user.js

This section by and large has to do with disabling features that phone home to
services that are not available in i2p and which may be privacy-harmful because
they phone home to other services or open side-channels to cache identifying
data on the user's disk.

        // Privacy-harden and disable irrelevant features.
        user_pref("app.normandy.api_url", "");
        user_pref("app.normandy.enabled", false);

The user can update Firefox or TBB on their official profiles, there's no place
to update from in i2p except for people using the in-i2p Debian mirror maybe.

        user_pref("app.update.auto", false);
        user_pref("app.update.enabled", false);
        user_pref("beacon.enabled", false);

Various caching and fingerprintable features, will expand soon, it's late.

        user_pref("browser.aboutHomeSnippets.updateUrl", "");
        user_pref("browser.cache.disk_cache_ssl", false);
        user_pref("browser.cache.disk.enable", false);
        user_pref("browser.cache.offline.enable", false);
        user_pref("browser.disableResetPrompt", true);
        user_pref("browser.display.use_document_fonts", 0);
        user_pref("browser.fixup.alternate.enabled", false);
        user_pref("browser.formfill.enable", false);

One of these services which doesn't work in i2p and speaks to a privacy-hostile
service is Safe Browsing which atempts to identify malware. Use caution, in this
case your browser is more able to provide privacy, but less able to provide
protection.

        user_pref("browser.library.activity-stream.enabled", false);
        user_pref("browser.newtabpage.activity-stream.disableSnippets", true);
        user_pref("browser.newtabpage.activity-stream.enabled", false);
        user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
        user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
        user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
        user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
        user_pref("browser.newtabpage.activity-stream.prerender", false);
        user_pref("browser.newtabpage.activity-stream.showSearch", false);
        user_pref("browser.newtabpage.enhanced", false);
        user_pref("browser.newtabpage.introShown", true);
        user_pref("browser.newtab.preload", false);
        user_pref("browser.onboarding.enabled", false);
        user_pref("browser.pagethumbnails.capturing_disabled", true);
        user_pref("browser.safebrowsing.appRepURL", "");
        user_pref("browser.safebrowsing.blockedURIs.enabled", false);
        user_pref("browser.safebrowsing.downloads.enabled", false);
        user_pref("browser.safebrowsing.downloads.remote.enabled", false);
        user_pref("browser.safebrowsing.downloads.remote.url", "");
        user_pref("browser.safebrowsing.enabled", false);
        user_pref("browser.safebrowsing.malware.enabled", false);
        user_pref("browser.safebrowsing.phishing.enabled", false);
        user_pref("browser.search.geoip.timeout", 1);
        user_pref("browser.search.suggest.enabled", false);
        user_pref("browser.selfsupport.url", "");
        user_pref("browser.send_pings", false);
        user_pref("browser.shell.checkDefaultBrowser", false);
        user_pref("browser.startup.homepage_override.mstone", "ignore");
        user_pref("browser.startup.page", 0);
        user_pref("browser.toolbarbuttons.introduced.pocket-button", true);
        user_pref("browser.urlbar.speculativeConnect.enabled", false);
        user_pref("browser.urlbar.trimURLs", false);
        user_pref("datareporting.healthreport.uploadEnabled", false);
        user_pref("datareporting.policy.dataSubmissionEnabled", false);
        user_pref("dom.battery.enabled", false);
        user_pref("dom.enable_performance", false);
        user_pref("dom.enable_performance_navigation_timing", false);
        user_pref("dom.enable_resource_timing", false);
        user_pref("dom.event.clipboardevents.enabled", false);
        user_pref("dom.gamepad.enabled", false);
        user_pref("dom.indexedDB.enabled", false);
        user_pref("dom.min_timeout_value", 400);
        user_pref("dom.push.connection.enabled", false);
        user_pref("dom.push.enabled", false);
        user_pref("dom.serviceWorkers.enabled", false);
        user_pref("dom.serviceWorkers.interception.enabled", false);
        user_pref("dom.storage.enabled", false);
        user_pref("dom.webaudio.enabled", false);
        user_pref("extensions.autoDisableScopes", 14);
        user_pref("extensions.getAddons.cache.enabled", false);
        user_pref("extensions.getAddons.showPane", false);
        user_pref("extensions.pocket.enabled", false);
        user_pref("extensions.screenshots.disabled", true);
        user_pref("extensions.webservice.discoverURL", "");
        user_pref("geo.enabled", false);
        user_pref("geo.wifi.uri", "");
        user_pref("gfx.downloadable_fonts.disable_cache", true);
        user_pref("javascript.options.shared_memory", false);
        user_pref("layout.css.visited_links_enabled", false);
        user_pref("media.autoplay.enabled", false);
        user_pref("media.cache_size", 0);
        user_pref("media.navigator.enabled", false);
        user_pref("media.peerconnection.enabled", false);
        user_pref("media.video_stats.enabled", false);
        user_pref("captivedetect.canonicalURL", "");
        user_pref("network.captive-portal-service.enabled", false);
        user_pref("network.cookie.cookieBehavior", 1);
        user_pref("network.cookie.lifetimePolicy", 2);
        user_pref("network.dns.disablePrefetch", true);
        user_pref("network.http.referer.spoofSource", true);
        user_pref("network.http.referer.trimmingPolicy", 2);
        user_pref("network.http.referer.XOriginPolicy", 2);
        user_pref("network.prefetch-next", false);
        user_pref("privacy.donottrackheader.enabled", true);
        user_pref("privacy.donottrackheader.value", 1);
        user_pref("toolkit.telemetry.archive.enabled", false);
        user_pref("toolkit.telemetry.coverage.opt-out", true);
        user_pref("toolkit.telemetry.enabled", false);
        user_pref("toolkit.telemetry.server", "");
        user_pref("toolkit.telemetry.unified", false);
        user_pref("webgl.disabled", true);
        user_pref("browser.chrome.errorReporter.infoURL", "");
        user_pref("breakpad.reportURL", "");
        user_pref("browser.newtabpage.activity-stream.default.sites", "");
        //user_pref("browser.newtabpage.activity-stream.default.sites", "http://planet.i2p/,http://legwork.i2p/,http://i2pwiki.i2p/,http://i2pforums.i2p/,http://zzz.i2p/");

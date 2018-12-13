
#### Screenshots

  * **check.kovri.i2p:**

![Figure D: check.kovri.i2p results](images/firefox.profile.i2p.png)

  * **valve/fingerprintjs**

![Figure E: Browser Fingerprint](images/firefox.profile.i2p.fingerprint.png)

#### Footnotes [Download these notes](NOTES.md)

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

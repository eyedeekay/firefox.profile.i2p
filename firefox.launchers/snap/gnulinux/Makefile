
username=$(shell who am i | awk '{print $$1}')

#user:
	#@echo /home/$(username)

install:
	cp -rv . /usr/lib/firefox.profile.i2p/
	chmod a+rx /usr/lib/firefox.profile.i2p/firefox.profile.i2p
	chmod a+rx /usr/lib/firefox.profile.i2p/firefox.profile.i2p/extensions
	install -m755 I2PBrowser.sh /usr/bin/
	install -m755 I2PBrowser-Private.sh /usr/bin/
	install -m755 i2pbrowser-firefox.desktop \
		/usr/share/applications/i2pbrowser-firefox.desktop
	install -m755 i2pbrowser-firefox-private.desktop \
		/usr/share/applications/i2pbrowser-firefox-private.desktop

install-debian:
	cp -v ./user.js /usr/lib/firefox.profile.i2p/
	cp -v ./bookmarks.html /usr/lib/firefox.profile.i2p/
	mkdir -p /usr/lib/firefox.profile.i2p/firefox.profile.i2p/extensions
	install -m755 I2PBrowser.sh /usr/bin/
	install -m755 I2PBrowser-Private.sh /usr/bin/
	install -m755 i2pbrowser-firefox.desktop \
		/usr/share/applications/i2pbrowser-firefox.desktop
	install -m755 i2pbrowser-firefox-private.desktop \
		/usr/share/applications/i2pbrowser-firefox-private.desktop

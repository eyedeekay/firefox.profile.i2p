
username=$(shell who am i | awk '{print $$1}')

#user:
	#@echo /home/$(username)

install:
	mkdir -p /usr/lib/firefox.profile.i2p/
	cp -rv ./gnulinux /usr/lib/firefox.profile.i2p/firefox.profile.i2p
	chmod a+rx /usr/lib/firefox.profile.i2p/firefox.profile.i2p
	chmod a+rx /usr/lib/firefox.profile.i2p/firefox.profile.i2p/extensions
	install -m755 ./gnulinux/install.sh /usr/lib/firefox.profile.i2p/install.sh
	install -m755 ./gnulinux/I2PBrowser.sh /usr/bin/
	install -m755 ./gnulinux/I2PBrowser-Private.sh /usr/bin/
	install -m755 ./gnulinux/i2pbrowser-firefox.desktop \
		/usr/share/applications/i2pbrowser-firefox.desktop
	install -m755 i2pbrowser-firefox-private.desktop \
		/usr/share/applications/i2pbrowser-firefox-private.desktop

install-debian:
	mkdir -p /usr/lib/firefox.profile.i2p/firefox.profile.i2p/extensions
	cp -v ./user.js /usr/lib/firefox.profile.i2p/
	cp -v ./bookmarks.html /usr/lib/firefox.profile.i2p/
	chmod a+rx /usr/lib/firefox.profile.i2p/firefox.profile.i2p
	chmod a+rx /usr/lib/firefox.profile.i2p/firefox.profile.i2p/extensions
	install -m755 ./firefox.launchers/gnulinux/install.sh /usr/lib/firefox.profile.i2p/install.sh
	install -m755 ./gnulinux/I2PBrowser.sh /usr/bin/
	install -m755 ./gnulinux/I2PBrowser-Private.sh /usr/bin/
	install -m755 ./gnulinux/i2pbrowser-firefox.desktop \
		/usr/share/applications/i2pbrowser-firefox.desktop
	install -m755 ./gnulinux/i2pbrowser-firefox-private.desktop \
		/usr/share/applications/i2pbrowser-firefox-private.desktop

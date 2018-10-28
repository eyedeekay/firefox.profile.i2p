
MS_UUID=6a0b33eb-12b9-45e9-8767-1d28191ee964

CREATE_DMG=$(shell pwd)/create-dmg/create-dmg

CREATE_MSI=nodejs ${HOME}/node_modules/.bin/msi-packager

echo:
	@echo "USAGE for this makefile here."

help:
	$(CREATE_DMG) --help

clean:
	rm -f *.zip *.msi *.tar.gz *.dmg

install: setup profile
	install -m755 firefox.launchers/i2pbrowser-firefox.desktop \
		/usr/share/applications/i2pbrowser-firefox.desktop

install-user: setup profile
	install -m755 firefox.launchers/i2pbrowser-firefox.desktop \
		$(HOME)/.local/share/applications/i2pbrowser-firefox.desktop

profile:
	cp -rv firefox.profile.i2p/* $(HOME)/.mozilla/firefox/firefox.profile.i2p

uninstall: remove

remove:
	rm -fr $(HOME)/.mozilla/firefox/firefox.profile.i2p

setup: $(HOME)/.mozilla/firefox/firefox.profile.i2p $(HOME)/.local/share/applications/

$(HOME)/.mozilla/firefox/firefox.profile.i2p:
	mkdir -p $(HOME)/.mozilla/firefox/firefox.profile.i2p

$(HOME)/.local/share/applications/menu-xdg:
	mkdir -p $(HOME)/.local/share/applications/menu-xdg

reinstall: remove install

run:
	gtk-launch $(HOME)/.local/share/applications/i2pbrowser-firefox.desktop

mslinks:
	./mslink.sh --lnk-target 'firefox.exe -no-remote -profile %APPDATA%\Mozilla\Firefox\Profiles\firefox.profile.i2p' -o firefox.launchers/windows/i2pbrowser.lnk
	./mslink.sh --lnk-target 'firefox.exe -no-remote -profile %APPDATA%\Mozilla\Firefox\Profiles\firefox.profile.i2p -private-window about:blank' -o firefox.launchers/windows/i2pbrowser-private.lnk

recopy-windows:
	rm -rf firefox.launchers/windows/firefox.profile.i2p/
	cp -rv firefox.profile.i2p firefox.launchers/windows/firefox.profile.i2p/

windows: recopy-windows mslinks win64 win32

win64:
	$(CREATE_MSI) \
		${PWD}/firefox.launchers/windows \
		${PWD}/i2pbrowser-firefox_x64.msi \
		-n 'I2PBrowser-Profile' \
		-v .1 \
		-m eyedeekay \
		-a x64 \
		-u ${MS_UUID} \
		-e ${PWD}/firefox.launchers/windows/i2pbrowser.lnk \
		-e ${PWD}/firefox.launchers/windows/i2pbrowser-private.lnk \
		-i ${PWD}/firefox.launchers/ui2pbrowser_icon.ico \
		-l

win64-check:
	msiinfo tables ${PWD}/i2pbrowser-firefox_x64.msi
	msiinfo streams ${PWD}/i2pbrowser-firefox_x64.msi

win32:
	$(CREATE_MSI) \
		${PWD}/firefox.launchers/windows \
		${PWD}/i2pbrowser-firefox_x86.msi \
		-n 'I2PBrowser-Profile' \
		-v .1 \
		-m eyedeekay \
		-a x86 \
		-u ${MS_UUID} \
		-e ${PWD}/firefox.launchers/windows/i2pbrowser.lnk \
		-e ${PWD}/firefox.launchers/windows/i2pbrowser-private.lnk \
		-i ${PWD}/firefox.launchers/ui2pbrowser_icon.ico \
		-l

zip:
	zip i2pbrowser-profile.zip -r firefox.profile.i2p
	zip i2pbrowser-windows.zip -r firefox.launchers/windows
	zip i2pbrowser-osx.zip -r firefox.launchers/osx
	zip i2pbrowser-gnulinux.zip -r firefox.launchers/gnulinux

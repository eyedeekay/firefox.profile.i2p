
MS_UUID=6a0b33eb-12b9-45e9-8767-1d28191ee964

CREATE_DMG=$(shell pwd)/create-dmg/create-dmg

CREATE_MSI=nodejs ${HOME}/node_modules/.bin/msi-packager

GOPATH=$(shell pwd)/.go

GOTHUB_BIN=$(GOPATH)/bin/gothub

VERSION=0.01

echo:
	@echo "USAGE for this makefile here."

include config.mk

all: guide windows linux zip

clean:
	rm -frv *.zip *.msi *.tar.gz *.dmg firefox.launchers/build

clean-build:
	rm -rfv firefox.launchers/build

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

recopy-linux:
	rm -rf firefox.launchers/gnulinux/firefox.profile.i2p/
	cp -rv firefox.profile.i2p firefox.launchers/gnulinux/firefox.profile.i2p/
	cp LINUX.md firefox.launchers/gnulinux/README.md

linux: recopy-linux
	mkdir -p firefox.launchers/build/i2pbrowser-gnulinux
	cp -rfv firefox.launchers/gnulinux/  firefox.launchers/build/i2pbrowser-gnulinux/i2pbrowser-gnulinux/
	cd firefox.launchers/build/i2pbrowser-gnulinux/ && tar cvzf ../../../i2pbrowser-gnulinux-$(VERSION).tar.gz .
	cp i2pbrowser-gnulinux-$(VERSION).tar.gz i2pbrowser-gnulinux.tar.gz
	rm -rfv firefox.launchers/build

recopy-windows:
	rm -rf firefox.launchers/windows/firefox.profile.i2p/
	cp -rv firefox.profile.i2p firefox.launchers/windows/firefox.profile.i2p/
	cp WINDOWS.md firefox.launchers/windows/README.md

windows: recopy-windows mslinks win64 win32

win64:
	$(CREATE_MSI) \
		${PWD}/firefox.launchers/windows \
		${PWD}/i2pbrowser-firefox-$(VERSION)_x64.msi \
		-n 'I2PBrowser-Profile' \
		-v $(VERSION) \
		-m eyedeekay \
		-a x64 \
		-u ${MS_UUID} \
		-e ${PWD}/firefox.launchers/windows/i2pbrowser.lnk \
		-e ${PWD}/firefox.launchers/windows/i2pbrowser-private.lnk \
		-i ${PWD}/firefox.launchers/windows/ui2pbrowser_icon.ico \
		-l
	cp ${PWD}/i2pbrowser-firefox-$(VERSION)_x64.msi ${PWD}/i2pbrowser-firefox_x64.msi

win64-check:
	msiinfo tables ${PWD}/i2pbrowser-firefox_x64.msi
	msiinfo streams ${PWD}/i2pbrowser-firefox_x64.msi

win32:
	$(CREATE_MSI) \
		${PWD}/firefox.launchers/windows \
		${PWD}/i2pbrowser-firefox-$(VERSION)_x86.msi \
		-n 'I2PBrowser-Profile' \
		-v $(VERSION) \
		-m eyedeekay \
		-a x86 \
		-u ${MS_UUID} \
		-e ${PWD}/firefox.launchers/windows/i2pbrowser.lnk \
		-e ${PWD}/firefox.launchers/windows/i2pbrowser-private.lnk \
		-i ${PWD}/firefox.launchers/windows/ui2pbrowser_icon.ico \
		-l
	cp ${PWD}/i2pbrowser-firefox-$(VERSION)_x86.msi ${PWD}/i2pbrowser-firefox_x86.msi

zip-bareprofile: clean-build
	zip i2pbrowser-profile-$(VERSION).zip -r firefox.profile.i2p

zip-windows: clean-build
	mkdir -p firefox.launchers/build/i2pbrowser-windows
	cp -rfv firefox.launchers/windows/  firefox.launchers/build/i2pbrowser-windows/i2pbrowser-windows/
	cd firefox.launchers/build/ && \
		zip i2pbrowser-windows-$(VERSION).zip -r i2pbrowser-windows && \
		mv i2pbrowser-windows-$(VERSION).zip $(PWD)/i2pbrowser-windows-$(VERSION).zip
	cp i2pbrowser-windows-$(VERSION).zip $(PWD)/i2pbrowser-windows.zip
	rm -rfv firefox.launcher/build

zip-osx: clean-build
	mkdir -p firefox.launchers/build/i2pbrowser-osx
	cp -rfv firefox.launchers/osx/  firefox.launchers/build/i2pbrowser-osx/i2pbrowser-osx/
	cd firefox.launchers/build/ && \
		zip i2pbrowser-osx-$(VERSION).zip -r i2pbrowser-osx && \
		mv i2pbrowser-osx-$(VERSION).zip $(PWD)/i2pbrowser-osx-$(VERSION).zip
	cp i2pbrowser-osx-$(VERSION).zip $(PWD)/i2pbrowser-osx.zip
	rm -rfv firefox.launcher/build

zip-gnulinux: clean-build
	mkdir -p firefox.launchers/build/i2pbrowser-gnulinux
	cp -rfv firefox.launchers/gnulinux/  firefox.launchers/build/i2pbrowser-gnulinux/i2pbrowser-gnulinux/
	cd firefox.launchers/build/ && \
		zip i2pbrowser-gnulinux-$(VERSION).zip -r i2pbrowser-gnulinux && \
		mv i2pbrowser-gnulinux-$(VERSION).zip $(PWD)/i2pbrowser-gnulinux-$(VERSION).zip
	cp $(PWD)/i2pbrowser-gnulinux-$(VERSION).zip $(PWD)/i2pbrowser-gnulinux.zip
	rm -rfv firefox.launcher/build

zip: zip-gnulinux zip-osx zip-windows

guide:
	cat HEADER.md WINDOWS.md MACOSX.md LINUX.md NOTES.md | \
		sed "s|\.zip|-$(VERSION)\.zip|g" | \
		sed "s|\.tar.gz|-$(VERSION)\.tar\.gz|g" | \
		tee README.md

gothub:
	go get -u github.com/itchio/gothub

gothub-version: gothub-delete-version
	$(GOTHUB_BIN) release \
		--tag $(VERSION) \
		--name firefox.profile.i2p.testing \
		--description "Testing version $(VERSION) of the i2p browser profile for all platforms" \
		--pre-release

gothub-delete-version:
	$(GOTHUB_BIN) delete \
		--tag $(VERSION); true

gothub-upload-version-linux:
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "GNU/Linux Testing Profile Alias(tar.gz version)" \
		--name i2pbrowser-gnulinux.tar.gz \
		--file i2pbrowser-gnulinux.tar.gz
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "GNU/Linux Testing Profile(tar.gz version)" \
		--name i2pbrowser-gnulinux-$(VERSION).tar.gz \
		--file i2pbrowser-gnulinux-$(VERSION).tar.gz
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "GNU/Linux Testing Profile Alias(zip version)" \
		--name i2pbrowser-gnulinux.zip \
		--file i2pbrowser-gnulinux.zip
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "GNU/Linux Testing Profile(zip version)" \
		--name i2pbrowser-gnulinux-$(VERSION).zip \
		--file i2pbrowser-gnulinux-$(VERSION).zip

gothub-upload-version-osx:
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "Mac OSX Testing Profile Alias" \
		--file i2pbrowser-osx.zip
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "Mac OSX Testing Profile" \
		--file i2pbrowser-osx-$(VERSION).zip

gothub-upload-version-windows:
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "Windows Testing Profile Alias" \
		--name i2pbrowser-windows.zip \
		--file i2pbrowser-windows.zip
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "Windows Testing Profile" \
		--name i2pbrowser-windows-$(VERSION).zip \
		--file i2pbrowser-windows-$(VERSION).zip
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "Windows .msi installer" \
		--name i2pbrowser-firefox-$(VERSION)_x64.msi \
		--file i2pbrowser-firefox-$(VERSION)_x64.msi
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "Windows .msi installer" \
		--name i2pbrowser-firefox-$(VERSION)_x86.msi \
		--file i2pbrowser-firefox-$(VERSION)_x86.msi
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "Windows .msi installer" \
		--name i2pbrowser-firefox_x64.msi \
		--file i2pbrowser-firefox_x64.msi
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "Windows .msi installer" \
		--name i2pbrowser-firefox_x86.msi \
		--file i2pbrowser-firefox_x86.msi

gothub-upload-version: gothub-upload-version-windows gothub-upload-version-osx gothub-upload-version-linux

gothub-current: gothub-delete-current
	$(GOTHUB_BIN) release \
		--tag current \
		--name firefox.profile.i2p \
		--description "Current version of the i2p browser profile for all platforms"

gothub-delete-current:
	$(GOTHUB_BIN) delete \
		--tag current; true

gothub-upload-current-linux:
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "GNU/Linux Profile Alias(tar.gz version)" \
		--name i2pbrowser-gnulinux.tar.gz \
		--file i2pbrowser-gnulinux.tar.gz
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "GNU/Linux Profile(tar.gz version)" \
		--name i2pbrowser-gnulinux-$(VERSION).tar.gz \
		--file i2pbrowser-gnulinux-$(VERSION).tar.gz
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "GNU/Linux Profile Alias(zip version)" \
		--name i2pbrowser-gnulinux.zip \
		--file i2pbrowser-gnulinux.zip
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "GNU/Linux Profile(zip version)" \
		--name i2pbrowser-gnulinux-$(VERSION).zip \
		--file i2pbrowser-gnulinux-$(VERSION).zip

gothub-upload-current-osx:
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Mac OSX Profile Alias" \
		--name i2pbrowser-osx.zip \
		--file i2pbrowser-osx.zip
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Mac OSX Profile" \
		--name i2pbrowser-osx-$(VERSION).zip \
		--file i2pbrowser-osx-$(VERSION).zip

sign-windows:
	#i2pbrowser-windows.zip
	#i2pbrowser-windows-$(VERSION).zip
	#i2pbrowser-firefox-$(VERSION)_x64.msi
	#i2pbrowser-firefox-$(VERSION)_x86.msi
	#i2pbrowser-firefox_x64.msi
	#i2pbrowser-firefox_x64.msi

gothub-upload-current-windows:
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Windows Profile Alias" \
		--name i2pbrowser-windows.zip \
		--file i2pbrowser-windows.zip
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Windows Profile" \
		--name i2pbrowser-windows-$(VERSION).zip \
		--file i2pbrowser-windows-$(VERSION).zip
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Windows .msi installer" \
		--name i2pbrowser-firefox-$(VERSION)_x64.msi \
		--file i2pbrowser-firefox-$(VERSION)_x64.msi
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Windows .msi installer" \
		--name i2pbrowser-firefox-$(VERSION)_x86.msi \
		--file i2pbrowser-firefox-$(VERSION)_x86.msi
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Windows .msi installer x64 Alias" \
		--name i2pbrowser-firefox_x64.msi \
		--file i2pbrowser-firefox_x64.msi
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Windows .msi installer x86 Alias" \
		--name i2pbrowser-firefox_x86.msi \
		--file i2pbrowser-firefox_x86.msi

gothub-upload-current: gothub-upload-current-windows gothub-upload-current-osx gothub-upload-current-linux upload-update

release: gothub-release-version

current-release: gothub-upload-current

bare-profile:
	zip i2pbrowser-profile-update.zip -r firefox.profile.i2p

upload-update:
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Bare Profile, experts only" \
		--name i2pbrowser-profile-update.zip \
		--replace \
		--file i2pbrowser-profile-update.zip

release-all: release current-release


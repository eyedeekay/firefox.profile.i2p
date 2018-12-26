
MS_UUID=6a0b33eb-12b9-45e9-8767-1d28191ee964

CREATE_DMG=$(shell pwd)/create-dmg/create-dmg

CREATE_MSI=nodejs ${HOME}/node_modules/.bin/msi-packager

GOPATH=$(shell pwd)/.go

GOTHUB_BIN=$(GOPATH)/bin/gothub


VERSIONMAJOR=0
VERSIONMINOR=04
VERSIONBUILD=
VERSION=$(VERSIONMAJOR).$(VERSIONMINOR)$(VERSIONBUILD)

echo:
	@echo "USAGE for this makefile here. $(WINDOWS_FIREFOX_PATH)"

version:
	@echo "!define VERSIONMAJOR $(VERSIONMAJOR)" > i2pbrowser-version.nsi
	@echo "!define VERSIONMINOR $(VERSIONMINOR)" >> i2pbrowser-version.nsi
	@echo "!define VERSIONBUILD $(VERSIONBUILD)" >> i2pbrowser-version.nsi

include config.mk
include .release.mk

all: lic guide windows linux zip debwhonix debfirefox

clean:
	rm -frv *.snap *.zip *.msi *.tar.gz *.dmg *.exe firefox.launchers/build

clean-build:
	rm -rfv firefox.launchers/build

install:
	cp -rv ./firefox.profile.i2p /usr/lib/firefox.profile.i2p/
	chmod a+rx /usr/lib/firefox.profile.i2p/firefox.profile.i2p
	chmod a+rx /usr/lib/firefox.profile.i2p/firefox.profile.i2p/extensions
	install -m755 ./firefox.launchers/gnulinux/install.sh /usr/lib/firefox.profile.i2p/install.sh
	install -m755 ./firefox.launchers/gnulinux/I2PBrowser.sh /usr/bin/
	install -m755 ./firefox.launchers/gnulinux/I2PBrowser-Private.sh /usr/bin/
	install -m755 ./firefox.launchers/gnulinux/i2pbrowser-firefox.desktop \
		/usr/share/applications/i2pbrowser-firefox.desktop
	install -m755 ./firefox.launchers/gnulinux/i2pbrowser-firefox-private.desktop \
		/usr/share/applications/i2pbrowser-firefox-private.desktop

install-debian:
	mkdir -p /usr/lib/firefox.profile.i2p/firefox.profile.i2p/extensions
	cp -v ./firefox.profile.i2p/user.js /usr/lib/firefox.profile.i2p/firefox.profile.i2p
	cp -v ./firefox.profile.i2p/bookmarks.html /usr/lib/firefox.profile.i2p/firefox.profile.i2p
	chmod a+rx /usr/lib/firefox.profile.i2p/firefox.profile.i2p
	chmod a+rx /usr/lib/firefox.profile.i2p/firefox.profile.i2p/extensions
	install -m755 ./firefox.launchers/gnulinux/install.sh /usr/lib/firefox.profile.i2p/install.sh
	install -m755 ./firefox.launchers/gnulinux/I2PBrowser.sh /usr/bin/
	install -m755 ./firefox.launchers/gnulinux/I2PBrowser-Private.sh /usr/bin/
	install -m755 ./firefox.launchers/gnulinux/i2pbrowser-firefox.desktop \
		/usr/share/applications/i2pbrowser-firefox.desktop
	install -m755 ./firefox.launchers/gnulinux/i2pbrowser-firefox-private.desktop \
		/usr/share/applications/i2pbrowser-firefox-private.desktop

fix-perms:
	chown $(SUDO_USER):$(SUDO_USER) ./firefox.launchers/*/firefox.profile.i2p/
	chown $(SUDO_USER):$(SUDO_USER) ./firefox.launchers/*/firefox.profile.i2p/extensions
	chmod -R a+rx ./firefox.launchers/*/firefox.profile.i2p/
	chmod -R a+rx ./firefox.launchers/*/firefox.profile.i2p/extensions

profile:
	cp -rv firefox.profile.i2p/* $(HOME)/.mozilla/firefox/firefox.profile.i2p

uninstall: remove

remove:
	rm -fr $(HOME)/.mozilla/firefox/firefox.profile.i2p

setup: $(HOME)/.mozilla/firefox/firefox.profile.i2p

$(HOME)/.mozilla/firefox/firefox.profile.i2p:
	mkdir -p $(HOME)/.mozilla/firefox/firefox.profile.i2p

reinstall: remove install

run:
	gtk-launch $(HOME)/.local/share/applications/i2pbrowser-firefox.desktop

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

recopy-snap:
	rm -rf firefox.launchers/snap/gnulinux
	cp -v snapcraft.yaml firefox.launchers/snap/snapcraft.yaml
	sed -i 's|firefox.launchers/snap/gnulinux|gnulinux|g' firefox.launchers/snap/snapcraft.yaml
	cp -rv firefox.launchers/gnulinux/ firefox.launchers/snap/gnulinux

snap: recopy-snap
	docker build -f Dockerfiles/Dockerfile.snap -t eyedeekay/firefox.profile.i2p.snap .
	make copy-snap

copy-snap:
	docker run -i -t --name snapbuild eyedeekay/firefox.profile.i2p.snap &
	sleep 5
	docker cp snapbuild:/home/snap/snap/i2pbrowser_$(VERSION)_amd64.snap i2pbrowser_$(VERSION)_amd64.snap
	docker rm -f snapbuild

recopy-osx:
	rm -rf firefox.launchers/osx/firefox.profile.i2p/
	cp -rv firefox.profile.i2p firefox.launchers/osx/firefox.profile.i2p/
	cp -rv firefox.launchers/gnulinux/install.sh firefox.launchers/osx/helper.sh
	cp -rv assets firefox.launchers/assets
	cp MACOSX.md firefox.launchers/osx/README.md

osx: recopy-osx
	cp -rv firefox.launchers/osx "I2PBrowser"
	create-dmg "I2PBrowser.dmg" \
        --volname "I2PBrowser" \
        --volicon "I2PBrowser/assets/i2pbrowser-icon.icns" \
        --background "I2PBrowser/assets/ui2pbrowser_logo.png" \
        --window-pos 200 120 \
        --window-size 800 400 \
        --icon-size 128 \
        --hide-extension "I2PBrowser.sh" \
        --hide-extension "I2PBrowser-Private.sh" \
        --app-drop-link 600 185 \
        --hdiutil-verbose \
        "I2PBrowser/"
	rm -rf "I2PBrowser"

recopy-windows: version
	rm -rf firefox.launchers/windows/firefox.profile.i2p/
	cp -rv firefox.profile.i2p firefox.launchers/windows/firefox.profile.i2p/
	cp WINDOWS.md firefox.launchers/windows/README.md

windows: recopy-windows
	makensis i2pbrowser-installer.nsi
	cp install-i2pbrowser-$(VERSION).exe install-i2pbrowser.exe

wxs-windows: wix
	make -s wxs-docker

wxs-docker:
	docker build -f Dockerfile.WiX -t eyedeekay/i2p-firefox-wix . 2>/dev/null 1>/dev/null

wxs: wxs-windows
	make -s wxs2 > i2pbrowser-profile.wxs

wxs2:
	docker run -i --rm -t --name i2p-firefox-wix eyedeekay/i2p-firefox-wix

wixjson:
	@echo
	@echo '{'
	@echo '  "Name": "I2PBrowser-Profile",'
	@echo "  \"UpgradeCode\": \"$(MS_UUID)\","
	@echo "  \"Version\": \"$(VERSION)\","
	@echo "  \"Manufacturer\": \"$(BUILDER)\","
	@echo '  "Description": "I2P Firefox profile launcher",'
	@echo '  "Comments": "This package is licensed under MIT. It contains some BSD-Licensed code.",'
	@echo '  "Keywords": "i2p firefox browser profile",'
	@echo '  "_AppIcon": "firefox.launchers/windows/ui2pbrowser_icon.ico",'
	@echo '  "_ProgramMenuFolder": "I2P Browser Launcher",'
	@echo '    "_Shortcuts": ['
	@echo '       {"Name": "I2P Browser Launcher",'
	@echo '           "Description": "Automatically launch Firefox configured to work with i2p",'
	@echo '           "Target": "i2pbrowser.bat",'
	@echo '           "AddOnDesktop": true,'
	@echo '           "Open": [{"Extension": ".i2p.html",'
	@echo '                "Descriptrion": "File \".i2p.html\"",'
	@echo '                "EditWith": false,'
	@echo '                "IconIndex": "0",'
	@echo '                "MIME": "application/html"}],'
	@echo '           "OpenWith": [".html"]'
	@echo '       },'
	@echo '       {"Name": "I2P Browser Launcher Private Browsing mode",'
	@echo '           "Description": "Automatically launch Firefox configured to work with i2p",'
	@echo '           "Target": "i2pbrowser-private.bat",'
	@echo '           "AddOnDesktop": true,'
	@echo '           "Open": [{"Extension": ".i2p.html",'
	@echo '                "Descriptrion": "File \".i2p.html\"",'
	@echo '                "EditWith": false,'
	@echo '                "IconIndex": "0",'
	@echo '                "MIME": "application/html"}],'
	@echo '           "OpenWith": [".html"]'
	@echo '       }'
	@echo '    ],'
	@echo "  \"_SourceDir\": \"./firefox.launchers/windows\","
	@echo '  "_InstallDir": "I2PBrowser-Profile",'
	@echo '  "_OutputName": "i2pbrowser-firefox-0.01.msi",'
	@echo '  "_OutputDir": "./",'
	@echo '  "_SkipHidden": false'
	@echo '}'
	@echo

wix:
	make -s wixjson > wixpy.json

zip-bareprofile: clean-build
	zip i2pbrowser-profile-$(VERSION).zip -r firefox.profile.i2p

zip-windows: clean-build
	mkdir -p firefox.launchers/build/i2pbrowser-windows
	cp LICENSE_ALL firefox.launchers/windows/
	cp -rfv firefox.launchers/windows/  firefox.launchers/build/i2pbrowser-windows/i2pbrowser-windows/
	cd firefox.launchers/build/ && \
		zip i2pbrowser-windows-$(VERSION).zip -r i2pbrowser-windows && \
		mv i2pbrowser-windows-$(VERSION).zip $(PWD)/i2pbrowser-windows-$(VERSION).zip
	cp i2pbrowser-windows-$(VERSION).zip $(PWD)/i2pbrowser-windows.zip
	rm -rfv firefox.launcher/build

zip-osx: clean-build
	mkdir -p firefox.launchers/build/i2pbrowser-osx
	cp LICENSE_ALL firefox.launchers/osx/
	cp -rfv firefox.launchers/osx/  firefox.launchers/build/i2pbrowser-osx/i2pbrowser-osx/
	cd firefox.launchers/build/ && \
		zip i2pbrowser-osx-$(VERSION).zip -r i2pbrowser-osx && \
		mv i2pbrowser-osx-$(VERSION).zip $(PWD)/i2pbrowser-osx-$(VERSION).zip
	cp i2pbrowser-osx-$(VERSION).zip $(PWD)/i2pbrowser-osx.zip
	rm -rfv firefox.launcher/build

zip-gnulinux: clean-build
	mkdir -p firefox.launchers/build/i2pbrowser-gnulinux
	cp LICENSE_ALL firefox.launchers/gnulinux/
	cp -rfv firefox.launchers/gnulinux/  firefox.launchers/build/i2pbrowser-gnulinux/i2pbrowser-gnulinux/
	cd firefox.launchers/build/ && \
		zip i2pbrowser-gnulinux-$(VERSION).zip -r i2pbrowser-gnulinux && \
		mv i2pbrowser-gnulinux-$(VERSION).zip $(PWD)/i2pbrowser-gnulinux-$(VERSION).zip
	cp $(PWD)/i2pbrowser-gnulinux-$(VERSION).zip $(PWD)/i2pbrowser-gnulinux.zip
	rm -rfv firefox.launcher/build

zip: zip-gnulinux zip-osx zip-windows

guide:
	cat HEADER.md WINDOWS.md MACOSX.md LINUX.md NOTES.md WHONIX.md FINGER.md | tee README.md
		# \
		#sed "s|\.zip|-$(VERSION)\.zip|g" | \
		#sed "s|\.tar.gz|-$(VERSION)\.tar\.gz|g" | \
		#sed "s|_all.deb|_$(VERSION)-1_all.deb|g" | \
		#tee README.md

lic:
	cat license/LICENSE.index LICENSE license/MPL2.txt license/LICENSE.tor license/HTTPS-Everywhere.txt license/NoScript.txt | tee LICENSE_ALL
	sed 's|$$|\r|g' LICENSE_ALL | tee LICENSE.txt

inetc-plugin:
	/usr/bin/wget -c https://nsis.sourceforge.io/mediawiki/images/c/c9/Inetc.zip
	mkdir -p inetc
	cd inetc && unzip ../Inetc.zip

install-plugin:
	cp -v inetc/Plugins/amd64-unicode/INetC.dll /usr/share/nsis/Plugins/amd64-unicode/
	cp -v inetc/Plugins/x86-ansi/INetC.dll /usr/share/nsis/Plugins/x86-ansi/
	cp -v inetc/Plugins/x86-unicode/INetC.dll /usr/share/nsis/Plugins/x86-unicode/

debwhonix:
	cd whonix-helper && fakeroot-ng checkinstall --default \
		--install=no \
		--fstrans=yes \
		--maintainer=eyedeekay@safe-mail.net \
		--pkgname="i2pbrowser-whonix-helper" \
		--pkgversion="$(VERSION)" \
		--requires=tb-starter,tb-updater,open-link-confirmation,pv \
		--arch all \
		--pkglicense=mit \
		--pkggroup=net \
		--pkgsource=./ \
		--pkgaltsource="https://github.com/eyedeekay/firefox.profile.i2p" \
		--deldoc=yes \
		--deldesc=yes \
		--delspec=yes \
		--backup=no \
		--pakdir=../ make install

debfirefox:
	cd firefox.launchers/gnulinux && fakeroot-ng checkinstall --default \
		--install=no \
		--fstrans=yes \
		--maintainer=eyedeekay@safe-mail.net \
		--pkgname="i2pbrowser-helper" \
		--pkgversion="$(VERSION)" \
		--requires=firefox-esr,webext-noscript,webext-https-everywhere \
		--arch all \
		--pkglicense=mit \
		--pkggroup=net \
		--pkgsource=./ \
		--pkgaltsource="https://github.com/eyedeekay/firefox.profile.i2p" \
		--deldoc=yes \
		--deldesc=yes \
		--delspec=yes \
		--backup=no \
		--pakdir=../../ make install-debian


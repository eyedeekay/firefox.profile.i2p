
MS_UUID=6a0b33eb-12b9-45e9-8767-1d28191ee964

CREATE_DMG=$(shell pwd)/create-dmg/create-dmg

CREATE_MSI=nodejs ${HOME}/node_modules/.bin/msi-packager

GOPATH=$(shell pwd)/.go

GOTHUB_BIN=$(GOPATH)/bin/gothub


VERSIONMAJOR=0
VERSIONMINOR=03
VERSIONBUILD=b
VERSION=$(VERSIONMAJOR).$(VERSIONMINOR)$(VERSIONBUILD)

echo:
	@echo "USAGE for this makefile here. $(WINDOWS_FIREFOX_PATH)"

version:
	@echo "!define VERSIONMAJOR $(VERSIONMAJOR)" > i2pbrowser-version.nsi
	@echo "!define VERSIONMINOR $(VERSIONMINOR)" >> i2pbrowser-version.nsi
	@echo "!define VERSIONBUILD $(VERSIONBUILD)" >> i2pbrowser-version.nsi

include config.mk
include .release.mk

all: lic guide windows linux zip

clean:
	rm -frv *.zip *.msi *.tar.gz *.dmg *.exe firefox.launchers/build

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
	cp -rfv firefox.launchers/windows/  firefox.launchers/build/i2pbrowser-windows/i2pbrowser-windows/
	cp LICENSE_ALL firefox.launchers/windows/
	cd firefox.launchers/build/ && \
		zip i2pbrowser-windows-$(VERSION).zip -r i2pbrowser-windows && \
		mv i2pbrowser-windows-$(VERSION).zip $(PWD)/i2pbrowser-windows-$(VERSION).zip
	cp i2pbrowser-windows-$(VERSION).zip $(PWD)/i2pbrowser-windows.zip
	rm -rfv firefox.launcher/build

zip-osx: clean-build
	mkdir -p firefox.launchers/build/i2pbrowser-osx
	cp -rfv firefox.launchers/osx/  firefox.launchers/build/i2pbrowser-osx/i2pbrowser-osx/
	cp LICENSE_ALL firefox.launchers/windows/
	cd firefox.launchers/build/ && \
		zip i2pbrowser-osx-$(VERSION).zip -r i2pbrowser-osx && \
		mv i2pbrowser-osx-$(VERSION).zip $(PWD)/i2pbrowser-osx-$(VERSION).zip
	cp i2pbrowser-osx-$(VERSION).zip $(PWD)/i2pbrowser-osx.zip
	rm -rfv firefox.launcher/build

zip-gnulinux: clean-build
	mkdir -p firefox.launchers/build/i2pbrowser-gnulinux
	cp -rfv firefox.launchers/gnulinux/  firefox.launchers/build/i2pbrowser-gnulinux/i2pbrowser-gnulinux/
	cp LICENSE_ALL firefox.launchers/windows/
	cd firefox.launchers/build/ && \
		zip i2pbrowser-gnulinux-$(VERSION).zip -r i2pbrowser-gnulinux && \
		mv i2pbrowser-gnulinux-$(VERSION).zip $(PWD)/i2pbrowser-gnulinux-$(VERSION).zip
	cp $(PWD)/i2pbrowser-gnulinux-$(VERSION).zip $(PWD)/i2pbrowser-gnulinux.zip
	rm -rfv firefox.launcher/build

zip: zip-gnulinux zip-osx zip-windows

guide:
	cat HEADER.md WINDOWS.md MACOSX.md LINUX.md NOTES.md FINGER.md | \
		sed "s|\.zip|-$(VERSION)\.zip|g" | \
		sed "s|\.tar.gz|-$(VERSION)\.tar\.gz|g" | \
		tee README.md

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


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
		--label "Windows Testing Profile" \
		--name i2pbrowser-windows-$(VERSION).zip \
		--file i2pbrowser-windows-$(VERSION).zip
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "Windows Testing Profile Alias" \
		--name i2pbrowser-windows.zip \
		--file i2pbrowser-windows.zip
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "Windows .msi installer" \
		--name i2pbrowser-firefox-$(VERSION).msi \
		--file i2pbrowser-firefox-$(VERSION).msi
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "Windows .msi installer Alias" \
		--name i2pbrowser-firefox.msi \
		--file i2pbrowser-firefox.msi

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
		--replace \
		--file i2pbrowser-gnulinux.tar.gz
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "GNU/Linux Profile(tar.gz version)" \
		--name i2pbrowser-gnulinux-$(VERSION).tar.gz \
		--replace \
		--file i2pbrowser-gnulinux-$(VERSION).tar.gz
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "GNU/Linux Profile Alias(zip version)" \
		--name i2pbrowser-gnulinux.zip \
		--replace \
		--file i2pbrowser-gnulinux.zip
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "GNU/Linux Profile(zip version)" \
		--name i2pbrowser-gnulinux-$(VERSION).zip \
		--replace \
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
		--replace \
		--file i2pbrowser-osx-$(VERSION).zip

gothub-upload-current-windows:
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Windows Profile" \
		--name i2pbrowser-windows-$(VERSION).zip \
		--replace \
		--file i2pbrowser-windows-$(VERSION).zip
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Windows Profile Alias" \
		--name i2pbrowser-windows.zip \
		--replace \
		--file i2pbrowser-windows.zip
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Windows Installer" \
		--name install-i2pbrowser.exe \
		--replace \
		--file install-i2pbrowser.exe

#	$(GOTHUB_BIN) upload \
#		--tag current \
#		--label "Windows .msi installer" \
#		--name i2pbrowser-firefox-$(VERSION).msi \
#		--replace \
#		--file i2pbrowser-firefox-$(VERSION).msi
#	$(GOTHUB_BIN) upload \
#		--tag current \
#		--label "Windows .msi installer Alias" \
#		--name i2pbrowser-firefox.msi \
#		--replace \
#		--file i2pbrowser-firefox.msi

gothub-upload-current: gothub-upload-current-windows gothub-upload-current-osx gothub-upload-current-linux upload-update

gothub-release-version: gothub-version gothub-upload-version

release: gothub-release-version

current-release: gothub-upload-current

bare-profile:
	zip i2pbrowser-profile-update.zip -r firefox.profile.i2p
	sha256sum i2pbrowser-profile-update.zip > i2pbrowser-profile-update.zip.sha256sum
	gpg --clear-sign -u "$(SIGNING_KEY)" i2pbrowser-profile-update.zip.sha256sum

upload-update: bare-profile
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Bare Profile, experts only" \
		--name i2pbrowser-profile-update.zip \
		--replace \
		--file i2pbrowser-profile-update.zip
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Bare Profile, experts only(SHA256 Hash)" \
		--name i2pbrowser-profile-update.zip.sha256sum \
		--replace \
		--file i2pbrowser-profile-update.zip.sha256sum
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Bare Profile, experts only(Signed Hash)" \
		--name i2pbrowser-profile-update.zip.sha256sum.asc \
		--replace \
		--file i2pbrowser-profile-update.zip.sha256sum.asc

release-all: release current-release

page: guide
	markdown README.md > index.html

update-service:
	docker build -t eyedeekay/i2pbrowser-site .

update-service-volume:
	docker run -i -t -d --name "i2pbrowser-volume" \
		-v i2pbrowser-updates:/opt/eephttpd/ \
		eyedeekay/i2pbrowser-site \
		"eephttpd -n i2pbrowser-backend -s /opt/eephttpd/ -sh=sam-host -sp=7656 -r"; true

update-service-copies:
	docker cp . i2pbrowser-volume:/opt/eephttpd/www/

update-service-run: update-service-volume update-service-copies
	docker rm -f i2pbrowser-updates; true
	docker run -i -t -d --name "i2pbrowser-updates" \
		--network si \
		--restart always \
		--volumes-from "i2pbrowser-volume" \
		eyedeekay/i2pbrowser-site

docker: update-service update-service-run

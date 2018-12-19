
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
		--label "GNU/Linux Testing Profile(tar.gz version)" \
		--name i2pbrowser-gnulinux.tar.gz \
		--replace \
		--file i2pbrowser-gnulinux-$(VERSION).tar.gz
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "GNU/Linux Testing Profile(zip version)" \
		--name i2pbrowser-gnulinux.zip \
		--replace \
		--file i2pbrowser-gnulinux-$(VERSION).zip
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "GNU/Linux snap" \
		--name i2pbrowser_ammd64.snap \
		--replace \
		--file i2pbrowser_$(VERSION)_ammd64.snap

gothub-upload-version-osx:
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--name i2pbrowser-osx \
		--label "Mac OSX Testing Profile" \
		--replace \
		--file i2pbrowser-osx-$(VERSION).zip

gothub-upload-version-windows:
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "Windows Profile Zip" \
		--name i2pbrowser-windows.zip \
		--replace \
		--file i2pbrowser-windows-$(VERSION).zip
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label "Windows Installer" \
		--name install-i2pbrowser.exe \
		--replace \
		--file install-i2pbrowser-$(VERSION).exe

upload-version-deb:
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label ".deb package containing extra configuration for Whonix i2pbrowser on Debian" \
		--name i2pbrowser-whonix-helper_all.deb \
		--replace \
		--file i2pbrowser-whonix-helper_$(VERSION)-1_all.deb
	$(GOTHUB_BIN) upload \
		--tag $(VERSION) \
		--label ".deb package containing firefox-esr configuration" \
		--name i2pbrowser-helper_all.deb \
		--replace \
		--file i2pbrowser-helper_$(VERSION)-1_all.deb

gothub-upload-version: gothub-upload-version-windows gothub-upload-version-linux upload-version-deb

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
		--label "GNU/Linux Profile(tar.gz version)" \
		--name i2pbrowser-gnulinux.tar.gz \
		--replace \
		--file i2pbrowser-gnulinux-$(VERSION).tar.gz
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "GNU/Linux Profile(zip version)" \
		--name i2pbrowser-gnulinux.zip \
		--replace \
		--file i2pbrowser-gnulinux-$(VERSION).zip
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "GNU/Linux snap" \
		--name i2pbrowser_ammd64.snap \
		--replace \
		--file i2pbrowser_$(VERSION)_ammd64.snap

gothub-upload-current-osx:
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Mac OSX Profile Alias" \
		--name i2pbrowser-osx.zip \
		--replace \
		--file i2pbrowser-osx-$(VERSION).zip

gothub-upload-current-windows:
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Windows Profile Zip" \
		--name i2pbrowser-windows.zip \
		--replace \
		--file i2pbrowser-windows-$(VERSION).zip
	$(GOTHUB_BIN) upload \
		--tag current \
		--label "Windows Installer" \
		--name install-i2pbrowser.exe \
		--replace \
		--file install-i2pbrowser-$(VERSION).exe

gothub-upload-current: gothub-current gothub-upload-current-windows gothub-upload-current-linux upload-update upload-deb

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

upload-deb:
	$(GOTHUB_BIN) upload \
		--tag current \
		--label ".deb package containing extra configuration for Whonix i2pbrowser on Debian" \
		--name i2pbrowser-whonix-helper_all.deb \
		--replace \
		--file i2pbrowser-whonix-helper_$(VERSION)-1_all.deb
	$(GOTHUB_BIN) upload \
		--tag current \
		--label ".deb package containing extra configuration for Whonix i2pbrowser on Debian" \
		--name i2pbrowser-helper_all.deb \
		--replace \
		--file i2pbrowser-helper_$(VERSION)-1_all.debs

release-all: release current-release

page: guide
	@echo '<!DOCTYPE html>' | tee index.html
	@echo '<html lang="en">' | tee -a index.html
	@echo '<head>' | tee -a index.html
	@echo '<meta charset="utf-8" />' | tee -a index.html
	@echo '<title>firefox.profile.i2p</title>' | tee -a index.html
	#@echo '<link rel="stylesheet" href="assets/style.css" />' | tee -a index.html
	@echo '</head>' | tee -a index.html
	@echo '<body>' | tee -a index.html
	@echo '<div id="intro">' | tee -a index.html
	markdown HEADER.md | tee -a index.html
	@echo '</div>' | tee -a index.html
	@echo '<div id="windows">' | tee -a index.html
	markdown WINDOWS.md | tee -a index.html
	@echo '</div>' | tee -a index.html
	@echo '<div id="osx">' | tee -a index.html
	markdown MACOSX.md | tee -a index.html
	@echo '</div>' | tee -a index.html
	@echo '<div id="linux">' | tee -a index.html
	markdown LINUX.md | tee -a index.html
	@echo '</div>' | tee -a index.html
	@echo '<div id="notes">' | tee -a index.html
	markdown NOTES.md | tee -a index.html
	@echo '</div>' | tee -a index.html
	@echo '<div id="whonix">' | tee -a index.html
	markdown WHONIX.md | tee -a index.html
	@echo '</div>' | tee -a index.html
	@echo '<div id="finger">' | tee -a index.html
	markdown FINGER.md | tee -a index.html
	@echo '</div>' | tee -a index.html
	@echo '</body>' | tee -a index.html
	@echo '</html>' | tee -a index.html
	tidy -i -w 80 -m index.html

update-service:
	docker build -f Dockerfiles/Dockerfile.updatesite -t eyedeekay/i2pbrowser-site .

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

docker-update-service: update-service update-service-run

docker-browser:
	docker build -f Dockerfiles/Dockerfile -t eyedeekay/firefox.profile.i2p .

docker-firefox:
	docker build -f Dockerfiles/Dockerfile.firefox -t eyedeekay/firefox.profile.i2p.firefox .

docker-whonix:
	docker build -f Dockerfiles/Dockerfile.whonix -t eyedeekay/i2pbrowser-whonix .

docker:
	xhost +"local:docker@"
	docker run -i -t --rm \
		-e DISPLAY=:0 \
		--network host \
		--name i2p-browser \
		--volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
		eyedeekay/firefox.profile.i2p

firefox:
	xhost +"local:docker@"
	docker run -i -t --rm \
		-e DISPLAY=:0 \
		--network host \
		--name i2p-browser-firefox \
		--volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
		eyedeekay/firefox.profile.i2p.firefox

whonix:
	xhost +"local:docker@"
	docker run -i -t --rm \
		-e DISPLAY=:0 \
		--network host \
		--name i2p-browser-whonix \
		--volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
		--volume i2pbrowser-whonix:/home/user/ \
		eyedeekay/i2pbrowser-whonix

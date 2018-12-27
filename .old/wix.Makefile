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

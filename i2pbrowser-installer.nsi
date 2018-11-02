!define APPNAME "I2PBrowser-Launcher"
!define COMPANYNAME "I2P"
!define DESCRIPTION "This launches Firefox with a browser profile pre-configured to use i2p"
# These three must be integers
!define VERSIONMAJOR 0
!define VERSIONMINOR 0
!define VERSIONBUILD 1
# These will be displayed by the "Click here for support information" link in "Add/Remove Programs"
# It is possible to use "mailto:" links in here to open the email client

InstallDir "$PROGRAMFILES\${COMPANYNAME}\${APPNAME}"

# rtf or txt file - remember if it is txt, it must be in the DOS text format (\r\n)
LicenseData "LICENSE"
# This will be in the installer/uninstaller's title bar
Name "${COMPANYNAME} - ${APPNAME}"
Icon "firefox.launchers/windows/ui2pbrowser_icon.ico"
OutFile "install-i2pbrowser-${VERSIONMAJOR}.${VERSIONMINOR}${VERSIONBUILD}.exe"

# For removing Start Menu shortcut in Windows 7
RequestExecutionLevel user

# start default section
Section

    # set the installation directory as the destination for the following actions
    SetOutPath $INSTDIR

    # Install the launcher scripts
    FileOpen $0 "$INSTDIR\i2pbrowser.bat" w
    FileWrite $0 "@echo off"
    FileWrite $0 'start "" "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" -no-remote -profile $INSTDIR\firefox.profile.i2p'
    FileWrite $0 pause
    FileClose $0

    FileOpen $0 "$INSTDIR\i2pbrowser-private.bat" w
    FileWrite $0 "@echo off"
    FileWrite $0 'start "" "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" -no-remote -private -profile $INSTDIR\firefox.profile.i2p'
    FileWrite $0 pause
    FileClose $0

    # Install the profile
    SetOutPath "$INSTDIR\firefox.profile.i2p"
    File firefox.launchers/windows/firefox.profile.i2p/user.js
    File firefox.launchers/windows/firefox.profile.i2p/bookmarks.html

    # Install the extensions
    SetOutPath "$INSTDIR\firefox.profile.i2p\extensions"
    File "firefox.launchers/windows/firefox.profile.i2p/extensions/{73a6fe31-595d-460b-a920-fcc0f8843232}.xpi"
    File firefox.launchers/windows/firefox.profile.i2p/extensions/https-everywhere-eff@eff.org.xpi

    CreateShortCut "$SMPROGRAMS\${APPNAME}.lnk" "cmd /c $INSTDIR\i2pbrowser.bat"
    CreateShortCut "$SMPROGRAMS\Private Browsing-${APPNAME}.lnk" "cmd /c $INSTDIR\i2pbrowser-private.bat"
    # CreateShortCut "$DESKTOP\${APPNAME}.lnk" "cmd /c $INSTDIR\i2pbrowser.bat"
    # CreateShortCut "$DESKTOP\Private Browsing-${APPNAME}.lnk" "cmd /c $INSTDIR\i2pbrowser-private.bat"

    # create the uninstaller
    WriteUninstaller "$INSTDIR\uninstall-i2pbrowser.exe"

    # create a shortcut named "new shortcut" in the start menu programs directory
    # point the new shortcut at the program uninstaller
    CreateShortCut "$SMPROGRAMS\Uninstall-${APPNAME}.lnk" "$INSTDIR\uninstall.exe"
SectionEnd

# uninstaller section start
Section "uninstall"

    # first, delete the uninstaller
    Delete "$INSTDIR\uninstall.exe"

    # Uninstall the launcher scripts
    Delete $INSTDIR/i2pbrowser.bat
    Delete $INSTDIR/i2pbrowser-private.bat

    # Uninstall the profile
    Delete $INSTDIR/firefox.profile.i2p/user.js
    Delete $INSTDIR/firefox.profile.i2p/bookmarks.html

    # Uninstall the extensions
    Delete $INSTDIR/firefox.profile.i2p/extensions/{73a6fe31-595d-460b-a920-fcc0f8843232}.xpi
    Delete $INSTDIR/firefox.profile.i2p/extensions/https-everywhere-eff@eff.org.xpi

    # second, remove the link from the start menu
    Delete "$SMPROGRAMS\Uninstall-${APPNAME}.lnk"
    Delete "$SMPROGRAMS\Private Browsing-${APPNAME}.lnk"
    Delete "$SMPROGRAMS\Uninstall-${APPNAME}.lnk"
    Delete "$DESKTOP\${APPNAME}.lnk"
    Delete "$DESKTOP\Private Browsing-${APPNAME}.lnk"

# uninstaller section end
SectionEnd

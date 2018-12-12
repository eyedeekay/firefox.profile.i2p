!include nsis_strings/i2pbrowser-en_US.nsi
!include i2pbrowser-version.nsi

var FFINSTEXE
var TBINST
var I2PINSTEXE
var SHORTCUT

!define FFINSTEXE
!define TBINST
!define FFINSTEXE32 "$PROGRAMFILES32\Mozilla Firefox\"
!define FFINSTEXE64 "$PROGRAMFILES64\Mozilla Firefox\"

!define I2PINSTEXE
!define I2PINSTEXE32 "$PROGRAMFILES32\i2p\"
!define I2PINSTEXE64 "$PROGRAMFILES64\i2p\"

!define RAM_NEEDED_FOR_64BIT 0x80000000

InstallDir "$PROGRAMFILES\${COMPANYNAME}\${APPNAME}"

# rtf or txt file - remember if it is txt, it must be in the DOS text format (\r\n)
LicenseData "LICENSE.txt"
# This will be in the installer/uninstaller's title bar
Name "${COMPANYNAME} - ${APPNAME}"
Icon "firefox.launchers/windows/ui2pbrowser_icon.ico"
OutFile "install-i2pbrowser-${VERSIONMAJOR}.${VERSIONMINOR}${VERSIONBUILD}.exe"

RequestExecutionLevel admin

!include "MUI2.nsh"
!include LogicLib.nsh
!include x64.nsh

!include nsis_includes/i2pbrowser-strrep.nsh
!include nsis_includes/i2pbrowser-mozcompat.nsi
!include nsis_includes/i2pbrowser-functions.nsi

!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "${LAUNCH_TEXT}"
!define MUI_FINISHPAGE_RUN_FUNCTION "LaunchLink"


PageEx license
    licensetext "${LICENSE_TITLE}"
    licensedata "LICENSE.txt"
PageExEnd
PageEx directory
    dirtext "${FIREFOX_MESSAGE}"
    dirvar $FFINSTEXE
    PageCallbacks firefoxDetect
PageExEnd
Page instfiles
PageEx directory
    dirtext "${I2P_MESSAGE}"
    dirvar $I2PINSTEXE
    PageCallbacks routerDetect
PageExEnd

# start default section
Section Install

    # set the installation directory as the destination for the following actions
    createDirectory $INSTDIR
    SetOutPath $INSTDIR
    File firefox.launchers/windows/ui2pbrowser_icon.ico

    # Install the launcher scripts: This will need to be it's own section, since
    # now I think we just need to let the user select if the user is using a non
    # default Firefox path.
    FileOpen $0 "$INSTDIR\i2pbrowser.bat" w
    FileWrite $0 "@echo off"
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileWrite $0 'start "" "$FFINSTEXE\firefox.exe" -no-remote -profile "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p"'
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileWrite $0 exit
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileClose $0

    FileOpen $0 "$INSTDIR\i2pbrowser-private.bat" w
    FileWrite $0 "@echo off"
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileWrite $0 'start "" "$FFINSTEXE\firefox.exe" -no-remote -profile "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p" -private-window about:blank'
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileWrite $0 exit
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileClose $0

    # Copy the licenses
    createDirectory $INSTDIR\license
    SetOutPath $INSTDIR\license
    File LICENSE.txt
    File license/HTTPS-Everywhere.txt
    File license/LICENSE.tor
    File license/MPL2.txt
    File license/NoScript.txt

    # Install the profile
    createDirectory "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p"
    SetOutPath "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p"
    File firefox.launchers/windows/firefox.profile.i2p/user.js
    File firefox.launchers/windows/firefox.profile.i2p/bookmarks.html

    # Install the extensions
    createDirectory "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\extensions"
    SetOutPath "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\extensions"
    File "firefox.launchers/windows/firefox.profile.i2p/extensions/{73a6fe31-595d-460b-a920-fcc0f8843232}.xpi"
    File firefox.launchers/windows/firefox.profile.i2p/extensions/https-everywhere-eff@eff.org.xpi
    ${If} "${TBINST}" == "true"
        CopyFiles "$FFINSTEXE\TorBrowser\Data\Browser\profile.default\extensions\torbutton@torproject.org.xpi" "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\torbutton@torproject.org.xpi"
        CopyFiles "$FFINSTEXE\TorBrowser\Data\Browser\profile.default\extensions\tor-launcher@torproject.org.xpi" "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\tor-launcher@torproject.org.xpi"
    ${EndIf}

    SetOutPath "$INSTDIR"
    createDirectory "$SMPROGRAMS\${APPNAME}"
    CreateShortCut "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk" "C:\Windows\system32\cmd.exe" "/c $\"$INSTDIR\i2pbrowser.bat$\"" "$INSTDIR\ui2pbrowser_icon.ico"
    CreateShortCut "$SMPROGRAMS\${APPNAME}\Private Browsing-${APPNAME}.lnk" "C:\Windows\system32\cmd.exe" "/c $\"$INSTDIR\i2pbrowser-private.bat$\"" "$INSTDIR\ui2pbrowser_icon.ico"
    CreateShortCut "$DESKTOP\${APPNAME}.lnk" "C:\Windows\system32\cmd.exe" "/c $\"$INSTDIR\i2pbrowser.bat$\"" "$INSTDIR\ui2pbrowser_icon.ico"
    CreateShortCut "$DESKTOP\Private Browsing-${APPNAME}.lnk" "C:\Windows\system32\cmd.exe" "/c $\"$INSTDIR\i2pbrowser-private.bat$\"" "$INSTDIR\ui2pbrowser_icon.ico"

    ${StrRep} $SHORTCUT "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk" '\' '\\'

    !define SHORTCUTPATH $SHORTCUT

    SetShellVarContext current
    !define I2PAPPDATA "$APPDATA\I2P\"

    SetOutPath "${I2PAPPDATA}"

    ;# Point the browser config setting
    FileOpen $0 "${I2PAPPDATA}\clients.config" a
    FileSeek $0 0 END
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileWrite $0 "browser=$\"${SHORTCUTPATH}$\""
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileClose $0

    SetOutPath "$INSTDIR"
    # create the uninstaller
    WriteUninstaller "$INSTDIR\uninstall-i2pbrowser.exe"

    # create a shortcut to the uninstaller
    CreateShortCut "$SMPROGRAMS\${APPNAME}\Uninstall-${APPNAME}.lnk" "$INSTDIR\uninstall-i2pbrowser.exe"

SectionEnd

# uninstaller section start
Section "uninstall"

    # Uninstall the launcher scripts
    Delete $INSTDIR\i2pbrowser.bat
    Delete $INSTDIR\i2pbrowser-private.bat
    Delete $INSTDIR\ui2pbrowser_icon.ico
    Delete $INSTDIR\LICENSE.txt
    Delete $INSTDIR\license\HTTPS-Everywhere.txt
    Delete $INSTDIR\license\LICENSE.tor
    Delete $INSTDIR\license\MPL2.txt
    Delete $INSTDIR\license\NoScript.txt

    # Uninstall the profile
    Delete $LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\user.js
    Delete $LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\bookmarks.html

    # Uninstall the extensions
    Delete "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\extensions\{73a6fe31-595d-460b-a920-fcc0f8843232}.xpi"
    Delete "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\extensions\https-everywhere-eff@eff.org.xpi"

    # Remove shortcuts and folders
    Delete "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk"
    Delete "$SMPROGRAMS\${APPNAME}\Private Browsing-${APPNAME}.lnk"
    Delete "$SMPROGRAMS\Uninstall-${APPNAME}.lnk"
    Delete "$DESKTOP\${APPNAME}.lnk"
    Delete "$DESKTOP\Private Browsing-${APPNAME}.lnk"
    rmDir "$SMPROGRAMS\${APPNAME}"
    rmDir "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\extensions"
    rmDir "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p"
    rmDir "$LOCALAPPDATA\${APPNAME}"
    rmDir "$INSTDIR"

    # delete the uninstaller
    Delete "$INSTDIR\uninstall-i2pbrowser.exe"

    # uninstaller section end

SectionEnd

!insertmacro MUI_PAGE_FINISH

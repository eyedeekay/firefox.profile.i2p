;
; Defines
;

;
; Actually quite good documentation/reference at
; http://nsis.sourceforge.net/Docs/Chapter4.html
; This is a somewhat stack based language
;
; For MUI2 options see
; http://nsis.sourceforge.net/Docs/Modern%20UI%202/Readme.html

;
; Dependencies:
; ZipDLL
; wget http://nsis.sourceforge.net/mediawiki/images/d/d9/ZipDLL.zip
; unzip 
; cp ZipDLL.dll /usr/local/opt/makensis/share/nsis/Plugins/x86-unicode
; wget http://nsis.sourceforge.net/mediawiki/images/c/c9/Inetc.zip
; unzip Inetc.zip
; cp -r Plugins/* /usr/local/opt/makensis/share/nsis/Plugins/
; wget https://github.com/eyedeekay/firefox.profile.i2p/releases/download/current/i2pbrowser-profile-update.zip
; unzip i2pbrowser-profile-update.zip
;
;
;

Name "I2P"
Caption "I2P Installer"
OutFile "i2p-installer-experimental.exe"
; Only here to tell that you should not set this!
; We relay on a method done in function .onInit which handles the
; x86/x86_64 case in regards of detecting previous installs of firefox, java and i2p itself.
;InstallDir "$PROGRAMFILES\I2P"

VIAddVersionKey "ProductName" "I2P Installer"
VIAddVersionKey "Comments" "A test comment"
VIAddVersionKey "CompanyName" "I2P"
VIAddVersionKey "LegalTrademarks" "Java Launcher is a trademark of Fake company"
VIAddVersionKey "LegalCopyright" "I2P"
VIAddVersionKey "FileDescription" "I2P Installer"
VIAddVersionKey "FileVersion" "1.0.0"
VIProductVersion "1.0.0.1"
 
!define CLASSPATH "i2pinstall_0.9.37.jar"
!define ENABLE_LOGGING
!define MUI_LICENSEPAGE_RADIOBUTTONS

;
; To get fresh URLs, you'll have to download them in the normal way at a browser, then in the download view, copy the link.
; Please ensure you got the **real** link in the download view, and not just "copy destination link" cause if it's a location
; change, the http fetcher would fail.
;

;
; Only the JRE_VERSION of the *_VERSION variables are in use right now.
;

; Definitions for Java 1.8
!define JRE_VERSION "8.0" ;8.0.192.12
!define JRE_URL "https://download.oracle.com/otn-pub/java/jdk/8u192-b12/750e1c8617c5452694857ad95c3ee230/jre-8u192-windows-x64.exe"

!define FIREFOX_VERSION "63.0.1"
!define FIREFOX_URL "https://download-installer.cdn.mozilla.net/pub/firefox/releases/63.0.1/win64/en-US/Firefox%20Setup%2063.0.1.exe"

!define I2P_VERSION "0.9.37"
!define I2P_URL "https://download.i2p2.de/releases/0.9.37/i2pinstall_0.9.37.jar"

; use javaw.exe to avoid dosbox.
; use java.exe to keep stdout/stderr
!define JAVAEXE "javaw.exe"
 
RequestExecutionLevel user
AutoCloseWindow false
ShowInstDetails show

!addplugindir "."

; UI v2
!include "MUI2.nsh"

; Logging
!include "textlog.nsh"

!include "FileFunc.nsh"
!insertmacro GetFileVersion
!insertmacro GetParameters
!include "WordFunc.nsh"
!insertmacro VersionCompare
!include "UAC.nsh"
!include "x64.nsh"

!insertmacro MUI_LANGUAGE "English"
 
!define MUI_ABORTWARNING # This will warn the user if they exit from the installer.

!define MUI_TEXT_WELCOME_INFO_TITLE "I2P Installation Pack"
!define MUI_TEXT_WELCOME_INFO_TEXT "This package will install I2P for you, it will also install both Mozilla Firefox and Java if those are not present already."

!define MUI_LICENSEPAGE_TEXT_TOP "I2P needs to install Java. Please review the Oracle Java license terms"
!define MUI_PAGE_HEADER_TEXT "Welcome to the I2P Pack installer"
!define MUI_LICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "Yes, I do accept the Oracle License above"
!define MUI_LICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "No, I do not accept"

!insertmacro MUI_PAGE_LICENSE "OracleLicense.txt"
!insertmacro MUI_PAGE_DIRECTORY # In which folder install page.
!insertmacro MUI_PAGE_INSTFILES # Installing page.
!insertmacro MUI_PAGE_FINISH # Finished installation page.


Function .onInit # Function that will be executed on installer's start up.
  ; Important so it detects the correct path for JRE
  ${If} ${RunningX64}
    SetRegView 64
    ReadRegStr $0 HKLM Software\Microsoft\Windows\CurrentVersion ProgramFilesDir
    DetailPrint $0
    StrCpy $INSTDIR "$0\i2p"
    SetRegView 64
  ${EndIf}
  Call ElevateToAdmin
  SetOutPath "$INSTDIR"
  CreateDirectory "$INSTDIR"
  ${LogSetFileName} "$INSTDIR\InstallLog.txt"
  ${LogSetOn}
FunctionEnd

; Check if already available:
; HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Mozilla Firefox

Section "Install Firefox"
  Push $0
  Push $1
  ReadRegStr $0 HKLM "Software\Mozilla\Mozilla Firefox" CurrentVersion
  DetailPrint $0
  StrCmp $0 "63.0.1 (x64 en-US)" done
  error:
  inetc::get /BANNER "Downloading firefox" /NOCOOKIES "${FIREFOX_URL}" "$TEMP\firefox-windows-x64.exe" /end
  Pop $0
  ${if} $0 != "OK"
    MessageBox MB_OK "$(LocS_AdempiereDownloadFailed): $0"
    abort
  ${else}
    ; Silent install (always installs into the default location.)
    ; Documentation at https://wiki.mozilla.org/Installer:Command_Line_Arguments
    ExecWait "$TEMP\firefox-windows-x64.exe -ms"
  ${endif}
  done:
SectionEnd

Section "Download I2P"
  inetc::get /BANNER "Downloading I2P" /NOCOOKIES "${I2P_URL}" "$TEMP\i2pinstall_0.9.37.jar" /end
  Pop $0
  ${if} $0 != "OK"
    MessageBox MB_OK "$(LocS_AdempiereDownloadFailed): $0"
    abort
  ${endif}
SectionEnd

Section "Firefox I2P Profile"
  CreateDirectory $INSTDIR
  ${LogText} "Creating $APPDATA\firefox.profile.i2p"
  CreateDirectory $APPDATA\firefox.profile.i2p
  CreateDirectory $APPDATA\firefox.profile.i2p\extensions
  SetOutPath $APPDATA\firefox.profile.i2p
  File "firefox.profile.i2p/bookmarks.html"
  File "firefox.profile.i2p/user.js"
  SetOutPath $APPDATA\firefox.profile.i2p\extensions
  File "firefox.profile.i2p/extensions/https-everywhere-eff@eff.org.xpi"
  File "firefox.profile.i2p/extensions/{73a6fe31-595d-460b-a920-fcc0f8843232}.xpi"
  SetOutPath $INSTDIR
  ; Documentation for CLI args in firefox at:
  ; https://developer.mozilla.org/en-US/docs/Mozilla/Command_Line_Options
  CreateShortcut "$DESKTOP\Start I2P Browser.lnk" "$PROGRAMFILES64\Mozilla Firefox\firefox.exe" " -no-remote -profile $\"$APPDATA\firefox.profile.i2p$\"" "$PROGRAMFILES64\Mozilla Firefox\firefox.exe" 2 SW_SHOWNORMAL
  ${LogText} "Done installing firefox profile"
SectionEnd

Section "Launch I2P Installer"
  Call GetJRE
  Pop $R0
 
  ; change for your purpose (-jar etc.)
  ${GetParameters} $1
  StrCpy $0 '"$R0" -jar "$TEMP\i2pinstall_0.9.37.jar"'
  ${LogText} "Executing $0"
 
  SetOutPath $EXEDIR
  Exec $0
SectionEnd
;  returns the full path of a valid java.exe
;  looks in:
;  1 - .\jre directory (JRE Installed with application)
;  2 - JAVA_HOME environment variable
;  3 - the registry
;  4 - hopes it is in current dir or PATH
Function GetJRE
    Push $R0
    Push $R1
    Push $2
 
  ; 1) Check local JRE
  CheckLocal:
    ClearErrors
    StrCpy $R0 "$EXEDIR\jre\bin\${JAVAEXE}"
    IfFileExists $R0 JreFound
 
  ; 2) Check for JAVA_HOME
  CheckJavaHome:
    ClearErrors
    ReadEnvStr $R0 "JAVA_HOME"
    StrCpy $R0 "$R0\bin\${JAVAEXE}"
    IfErrors CheckRegistry     
    IfFileExists $R0 0 CheckRegistry
    Call CheckJREVersion
    IfErrors CheckRegistry JreFound
 
  ; 3) Check for registry
  CheckRegistry:
    ClearErrors
    ReadRegStr $R1 HKLM "Software\JavaSoft\Java Runtime Environment" "CurrentVersion"
    ReadRegStr $R0 HKLM "Software\JavaSoft\Java Runtime Environment\$R1" "JavaHome"
    StrCpy $R0 "$R0\bin\${JAVAEXE}"
    IfErrors DownloadJRE
    IfFileExists $R0 0 DownloadJRE
    Call CheckJREVersion
    IfErrors DownloadJRE JreFound
 
  DownloadJRE:
    MessageBox MB_ICONINFORMATION "${PRODUCT_NAME} uses Java Runtime Environment ${JRE_VERSION}, it will now be downloaded and installed."
    StrCpy $2 "$TEMP\jre-8u192-windows-x64.exe"
    #nsisdl::download /TIMEOUT=30000 ${JRE_URL} $2
    inetc::get /POPUP "Downloading java ${JRE_VERSION}..." /NOCOOKIES \
        /HEADER "Cookie: oraclelicense=accept-securebackup-cookie" \
        "${JRE_URL}" $2 /end
    Pop $0 # return value = exit code, "OK" means OK
        
    ${if} $0 != "OK"
      MessageBox MB_OK "$(LocS_AdempiereDownloadFailed): $0"
      abort
    ${else}
      MessageBox MB_OK "Success!"
      ; Documentation at https://www.java.com/en/download/help/silent_install.xml
      ExecWait "$TEMP\jre-8u192-windows-x64.exe /s SPONSORS=0"
    ${endif}
 
    ReadRegStr $R1 HKLM "Software\JavaSoft\Java Runtime Environment" "CurrentVersion"
    ReadRegStr $R0 HKLM "Software\JavaSoft\Java Runtime Environment\$R1" "JavaHome"
    StrCpy $R0 "$R0\bin\${JAVAEXE}"
    IfFileExists $R0 0 GoodLuck
    Call CheckJREVersion
    IfErrors GoodLuck JreFound
 
  ; 4) wishing you good luck
  GoodLuck:
    StrCpy $R0 "${JAVAEXE}"
    ; MessageBox MB_ICONSTOP "Cannot find appropriate Java Runtime Environment."
    ; Abort
 
  JreFound:
    Pop $2
    Pop $R1
    Exch $R0
FunctionEnd
 
; Pass the "javaw.exe" path by $R0
Function CheckJREVersion
    Push $R1
 
    ; Get the file version of javaw.exe
    ${GetFileVersion} $R0 $R1
    ${LogText} "Installer java version: ${JRE_VERSION} Found installed version: $R1"
    ${VersionCompare} ${JRE_VERSION} $R1 $R1
 
    ; Check whether $R1 != "1"
    ClearErrors
    StrCmp $R1 "1" 0 CheckDone
    SetErrors
 
  CheckDone:
    Pop $R1
FunctionEnd
 
Section "-CleanUp"
  ${LogSetOff}
  ExecShell "open" "$INSTDIR\InstallLog.txt"
SectionEnd
 


; Attempt to give the UAC plug-in a user process and an admin process.
Function ElevateToAdmin
  UAC_Elevate:
    !insertmacro UAC_RunElevated
    StrCmp 1223 $0 UAC_ElevationAborted ; UAC dialog aborted by user?
    StrCmp 0 $0 0 UAC_Err ; Error?
    StrCmp 1 $1 0 UAC_Success ;Are we the real deal or just the wrapper?
    Quit
 
  UAC_ElevationAborted:
    # elevation was aborted, run as normal?
    MessageBox MB_ICONSTOP "This installer requires admin access, aborting!"
    Abort
 
  UAC_Err:
    MessageBox MB_ICONSTOP "Unable to elevate, error $0"
    Abort
 
  UAC_Success:
    StrCmp 1 $3 +4 ;Admin?
    StrCmp 3 $1 0 UAC_ElevationAborted ;Try again?
    MessageBox MB_ICONSTOP "This installer requires admin access, try again"
    goto UAC_Elevate 
FunctionEnd


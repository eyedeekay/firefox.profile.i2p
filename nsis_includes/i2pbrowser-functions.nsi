
Function .onInit
    Call ShouldInstall64Bit
    ${If} $0 == 1
        ${If} ${FileExists} "${FFINSTEXE64}/firefox.exe"
            StrCpy $FFINSTEXE "${FFINSTEXE64}"
            StrCpy $TBINST "false"
        ${EndIf}
        ${If} ${FileExists} "$PROFILE/OneDrive/Desktop/Tor Browser/Browser/firefox.exe"
            StrCpy $FFINSTEXE "$PROFILE/OneDrive/Desktop/Tor Browser/Browser/"
            StrCpy $TBINST "true"
        ${EndIf}
        ${If} ${FileExists} "$PROFILE/Desktop/Tor Browser/Browser/firefox.exe"
            StrCpy $FFINSTEXE "$PROFILE/Desktop/Tor Browser/Browser/"
            StrCpy $TBINST "true"
        ${EndIf}
    ${Else}
        ${If} ${FileExists} "${FFINSTEXE32}/firefox.exe"
            StrCpy $FFINSTEXE "${FFINSTEXE32}"
            StrCpy $TBINST "false"
        ${EndIf}
        ${If} ${FileExists} "$PROFILE/OneDrive/Desktop/Tor Browser/Browser/firefox.exe"
            StrCpy $FFINSTEXE "$PROFILE/OneDrive/Desktop/Tor Browser/Browser/"
            StrCpy $TBINST "true"
        ${EndIf}
        ${If} ${FileExists} "$PROFILE/Desktop/Tor Browser/Browser/firefox.exe"
            StrCpy $FFINSTEXE "$PROFILE/Desktop/Tor Browser/Browser/"
            StrCpy $TBINST "true"
        ${EndIf}
    ${EndIf}
    ${If} ${FileExists} "${I2PINSTEXE32}/i2p.exe"
        StrCpy $I2PINSTEXE "${I2PINSTEXE64}"
    ${EndIf}
    ${If} ${FileExists} "${I2PINSTEXE64}/i2p.exe"
        StrCpy $I2PINSTEXE "${I2PINSTEXE64}"
    ${EndIf}
FunctionEnd

Function firefoxDetect
    ${If} ${FileExists} "$FFINSTEXE/firefox.exe"
        Abort directory
    ${EndIf}
FunctionEnd

Function routerDetect
    ${If} ${FileExists} "$I2PINSTEXE/i2p.exe"
        Abort directory
    ${EndIf}
FunctionEnd

Function LaunchLink
  ExecShell "" "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk"
FunctionEnd

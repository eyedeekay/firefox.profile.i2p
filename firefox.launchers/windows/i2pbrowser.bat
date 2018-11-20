@echo off
REM bitsadmin /transfer i2pProfileUpdateJob /download https://github.com/eyedeekay/firefox.profile.i2p/releases/download/current/i2pbrowser-profile-update.zip .\i2pbrowser-profile-update.zip
if exist "C:\Program Files\Mozilla Firefox\firefox.exe" (
    start "" "C:\Program Files\Mozilla Firefox\firefox.exe" -no-remote -profile ".\firefox.profile.i2p"
) else (
    if exist "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" (
        start "" "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" -no-remote -profile ".\firefox.profile.i2p"
    )
)
exit

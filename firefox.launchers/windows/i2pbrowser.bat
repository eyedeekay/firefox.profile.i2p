@echo off
if exist "C:\Program Files\Mozilla Firefox\firefox.exe" (
    start "" "C:\Program Files\Mozilla Firefox\firefox.exe" -no-remote -profile ".\firefox.profile.i2p"
) else (
    if exist "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" (
        start "" "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" -no-remote -profile ".\firefox.profile.i2p"
    )
)
pause

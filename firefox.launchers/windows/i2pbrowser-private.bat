@echo off
start "" "C:\Program Files {x86}\Mozilla Firefox\firefox.exe" -no-remote -profile %LOCALAPPDATA%\I2PBrowser-Profile\firefox.profile.i2p.private -private-window about:blank
pause

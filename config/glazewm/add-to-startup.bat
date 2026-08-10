@echo off
setlocal enabledelayedexpansion

:: Get the directory where this script is located

echo ========================================
echo  GlazeWM - Add to startup
echo ========================================
echo.

where glazewm.exe >nul 2>&1

if errorlevel 1 (
    echo ERROR: glazewm.exe could not be found on PATH.
    echo.
    pause
    exit /b 1
)

for /f "delims=" %%i in ('where glazewm.exe') do (
    set "EXE_PATH=%%i"
    goto found
)

:found

echo This script creates a Windows scheduled task to automatically
echo start GlazeWM when you log in.
echo.

echo Found GlazeWM at:
echo %EXE_PATH%
echo.

set /p "CONFIRM=Is this the correct location? (Y/n): "

if /i "%CONFIRM%"=="n" (
    echo.
    echo Installation cancelled.
    pause
    exit /b 0
)

if /i "%CONFIRM%"=="no" (
    echo.
    echo Installation cancelled.
    pause
    exit /b 0
)

echo.
echo Creating scheduled task...
echo.

powershell.exe -NoProfile -Command ^
    "$action = New-ScheduledTaskAction -Execute '\"%EXE_PATH%\"';" ^
    "$trigger = New-ScheduledTaskTrigger -AtLogOn;" ^
    "$principal = New-ScheduledTaskPrincipal -UserId '%USERNAME%' -LogonType Interactive -RunLevel Limited;" ^
    "$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit 0;" ^
    "Unregister-ScheduledTask -TaskName 'GlazeWM' -Confirm:$false -ErrorAction SilentlyContinue;" ^
    "Register-ScheduledTask -TaskName 'GlazeWM' -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Force"

if !errorlevel! equ 0 (
    echo.
    echo GlazeWM will now start automatically at login.
    echo.
    echo To uninstall this task, run:
    echo     uninstall-startup.bat
    echo.
) else (
    echo.
    echo Task creation failed with error code: !errorlevel!
    echo.
)

pause

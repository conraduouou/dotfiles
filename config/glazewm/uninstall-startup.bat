@echo off
setlocal enabledelayedexpansion

echo ========================================
echo  GlazeWM - Remove from startup
echo ========================================
echo.

echo This will remove the GlazeWM scheduled startup task.
echo.

set /p "CONFIRM=Are you sure? (y/N): "

if /i not "%CONFIRM%"=="y" (
    echo.
    echo Uninstallation cancelled.
    pause
    exit /b 0
)

echo.
echo Removing scheduled task...
echo.

powershell.exe -NoProfile -Command ^
    "Unregister-ScheduledTask -TaskName 'GlazeWM' -Confirm:$false -ErrorAction SilentlyContinue"

if !errorlevel! equ 0 (
    echo.
    echo GlazeWM has been removed from startup.
    echo.
) else (
    echo.
    echo Failed to remove the GlazeWM startup task.
    echo.
)

pause

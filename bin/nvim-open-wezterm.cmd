@echo off
setlocal

rem Set current tab id by finding it through the WEZTERM_PANE env variable
set "tab_id="
for /F "tokens=2,3 skip=1" %%i in ('wezterm cli list') do (
    if "%WEZTERM_PANE%"=="%%j" (
        set "tab_id=%%i"
        goto after_loop
    )
)

:after_loop

rem If tab_id was not assigned for some reason, we don't like that, exit away
if not defined tab_id (
    echo "WezTerm tab ID was not successfully identified. Please inspect."
    exit /b 0
)

rem One Neovim named pipe per WezTerm pane.
set "pipe=\\.\pipe\nvim-wezterm-%tab_id%"

rem No arguments: start a server in the current pane.
if "%~1"=="" goto start_nvim

rem Absolute file path.
set "file=%~f1"

rem Check whether the Neovim pipe exists.
powershell.exe -NoProfile -Command "if (Test-Path -LiteralPath '%pipe%') { exit 0 } else { exit 1 }"

if not errorlevel 1 goto remote_file

rem No server yet: create a pane to the right.
wezterm cli split-pane --right --pane-id "%WEZTERM_PANE%" -- nvim.exe --listen "%pipe%" "%file%"
goto :eof

:remote_file
nvim.exe --server "%pipe%" --remote "%file%"
goto :eof

:start_nvim
nvim.exe --listen "%pipe%"

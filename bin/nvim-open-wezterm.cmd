@echo off
setlocal

rem One Neovim named pipe per WezTerm pane.
set "pipe=\\.\pipe\nvim-wezterm-%WEZTERM_PANE%"

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
goto :eof

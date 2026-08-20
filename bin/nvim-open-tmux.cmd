@echo off
setlocal

rem Identify the current psmux window.
for /f "delims=" %%I in ('psmux display-message -p "#{window_id}"') do set "window_id=%%I"

rem One Neovim named pipe per psmux window.
set "pipe=\\.\pipe\nvim-psmux-%window_id%"
set "spawn_pipe=\\\\.\pipe\nvim-psmux-%window_id%"

rem No arguments.
if "%~1"=="" goto start_nvim

rem Absolute file path.
set "file=%~f1"

rem Check whether the Neovim pipe exists.
powershell.exe -NoProfile -Command "if (Test-Path -LiteralPath '%pipe%') { exit 0 } else { exit 1 }"

if not errorlevel 1 goto remote_file

rem No server yet.
psmux split-window -h -c "#{pane_current_path}" -- cmd.exe /c 'nvim.exe --listen "%spawn_pipe%" "%file%"'
goto :eof

:remote_file
nvim.exe --server "%pipe%" --remote "%file%"
goto :eof

:start_nvim
nvim.exe --listen "%pipe%"
goto :eof

:normal_nvim
nvim.exe %*
goto :eof

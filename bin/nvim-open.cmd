@echo off
setlocal

rem Outside psmux: behave exactly like normal nvim.
if "%TMUX%"=="" (
    nvim %*
    exit /b %ERRORLEVEL%
)

rem Identify the current psmux window.
for /f "delims=" %%I in ('psmux display-message -p "#{window_id}"') do set "window_id=%%I"

rem One Neovim named pipe per psmux window.
rem Normal path: used directly by nvim --server / --listen.
set "pipe=\\.\pipe\nvim-psmux-%window_id%"

rem Escaped path: used inside a command passed through psmux.
set "spawn_pipe=\\\\.\pipe\nvim-psmux-%window_id%"

rem No arguments:
rem Start Neovim normally, but make it listen on this window's pipe.
if "%~1"=="" (
    nvim --listen "%pipe%"
    exit /b %ERRORLEVEL%
)

rem File argument.
rem Convert the first argument to an absolute path.
for %%I in ("%~1") do set "file=%%~fI"

rem If the Neovim server is already listening, talk directly to it.
powershell.exe -NoProfile -Command "if (Test-Path -LiteralPath '%pipe%') { exit 0 } else { exit 1 }"
if not errorlevel 1 (
    nvim --server "%pipe%" --remote "%file%"
    exit /b %ERRORLEVEL%
)

rem No server yet:
rem Create Neovim in the current psmux window with its named pipe.
psmux split-window -h -c "#{pane_current_path}" -- cmd.exe /c nvim --listen "%spawn_pipe%" "%file%"

endlocal

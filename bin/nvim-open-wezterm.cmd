@echo off
setlocal

rem Set current tab id by finding it through the WEZTERM_PANE env variable
set "tab_id="
for /F "tokens=2,3 skip=1" %%i in ('wezterm cli list') do (
    if "%WEZTERM_PANE%"=="%%j" (
        set "tab_id=%%i"
        goto after_loop_1
    )
)
:after_loop_1

rem If tab_id was not assigned for some reason, we don't like that, exit away
if not defined tab_id (
    echo WezTerm tab ID was not successfully identified. Please inspect.
    exit /b 0
)

rem One Neovim named pipe per WezTerm pane.
set "pipe=\\.\pipe\nvim-wezterm-%tab_id%"

rem Absolute file path.
set "file=%~f1"

rem Check whether the Neovim pipe exists.
powershell.exe -NoProfile -Command "if (Test-Path -LiteralPath '%pipe%') { exit 0 } else { exit 1 }"
if not errorlevel 1 goto nvim_pipe


:nvim_no_pipe

rem No arguments: start a server in the current pane.
if "%~1"=="" (
    nvim.exe --listen "%pipe%"
    goto :eof
)

rem No server yet: create a pane to the left.
wezterm cli split-pane --left --pane-id "%WEZTERM_PANE%" -- nvim.exe --listen "%pipe%" "%file%"
goto :eof


:nvim_pipe

rem Check if there is any pane that runs nvim
for /F "tokens=2,6 skip=1" %%i in ('wezterm cli list') do (
    if "%%j"=="nvim.exe" if "%%i"=="%tab_id%" (
        set "is_running=1"
        goto after_loop_2
    )
)
:after_loop_2

if "%is_running%"==0 (
    rem Close orphaned nvim process, since no pane has nvim in the current tab
    powershell -NoProfile -Command "$p = Get-CimInstance Win32_Process -Filter \"Name='nvim.exe'\" | Where-Object CommandLine -like '*nvim-wezterm-%tabid%*' | Select-Object -First 1; if ($p) { taskkill /f /pid $p.ProcessId /t }"
    goto nvim_no_pipe
)

rem No arguments when there is already a running nvim pane should not be allowed
if "%~1"=="" (
    echo Separate nvim process in a single tab is not preferred.
    exit /b 0
)

rem Send the command through the pipe to open file in running nvim process
nvim.exe --server "%pipe%" --remote "%file%"
goto :eof

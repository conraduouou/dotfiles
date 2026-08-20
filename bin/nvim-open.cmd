@echo off

if not "%TMUX%"=="" (
    if exist "%~dp0nvim-open-tmux.cmd" (
        call "%~dp0nvim-open-tmux.cmd" %*
        goto :eof
    )
)

if not "%WEZTERM_PANE%"=="" (
    if exist "%~dp0nvim-open-wezterm.cmd" (
        call "%~dp0nvim-open-wezterm.cmd" %*
        goto :eof
    )
)

nvim.exe %*

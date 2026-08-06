:: open-file.cmd
@echo off

:loop
if "%~1"=="" goto :eof

start "" "%~1"
shift
goto loop

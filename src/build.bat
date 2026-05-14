@echo off
cd /D %~pd0
echo %CD%
call full_convert
wmake.py -m ..\makefile.am


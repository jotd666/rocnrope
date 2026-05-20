@echo off
cd /D %~pd0
echo %CD%
rem call full_convert
wmake.py -m ..\makefile.am


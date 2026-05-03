@echo off
cd /D %~pd0
echo %CD%
rem wmake.py -m ..\makefile.am clean
wmake.py -m ..\makefile.am RELEASE_BUILD=1



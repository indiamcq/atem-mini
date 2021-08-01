@echo off
set pathname=%~dp0
set script1=%1
set script2=%2
set script3=%3
set script4=%4
set script5=%5
set script6=%6
set script7=%7
set script8=%8
set script9=%9
set ext1=%script1:~-3%
set ext2=%script2:~-3%
set ext3=%script3:~-3%
set ext4=%script4:~-3%
set ext5=%script5:~-3%
set ext6=%script6:~-3%
set ext7=%script7:~-3%
set ext8=%script8:~-3%
set ext9=%script9:~-3%
if defined script1 call :%ext1% %script1%
if defined script2 call :%ext2% %script2%
if defined script3 call :%ext3% %script3%
if defined script4 call :%ext4% %script4%
if defined script5 call :%ext5% %script5%
if defined script6 call :%ext6% %script6%
if defined script7 call :%ext7% %script7%
if defined script8 call :%ext8% %script8%
if defined script9 call :%ext9% %script9%
goto :eof

:au3
set script=%~1
call "C:\Program Files (x86)\AutoIt3\AutoIt3.exe" "%pathname%%script%"
echo %script% was run.
goto :eof

:ahk
set script=%~1
call "C:\Program Files\AutoHotkey\AutoHotkey.exe" "%pathname%%script%"
echo %script% was run.
goto :eof

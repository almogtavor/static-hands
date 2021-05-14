@ECHO OFF
copy %~dp0windows\run.ahk "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
start %~dp0windows\run.ahk
PAUSE
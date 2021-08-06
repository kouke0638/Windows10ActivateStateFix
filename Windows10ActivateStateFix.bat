chcp 65001
@echo OFF
@title Windows10 ActivateStateFix

rem ==================== Check system administrator permissions ====================
cls
mode con cols=29 lines=3
echo.
echo 　　Check permissions
echo Administrator > %WINDIR%\System32\Administrator.txt
if not exist %WINDIR%\System32\Administrator.txt goto :NoAdmin
del /s /f /q %WINDIR%\System32\Administrator.txt > nul
rem ============================================================


rem ==================== Startup repair ====================
cls
mode con cols=42 lines=13


@echo ##################################
@echo     Preparing to start repair         
@echo ##################################

timeout /t 5
net stop sppsvc
net start sppsvc
timeout /t 2

cls
@echo ###############################################
@echo  If there is an error, please ignore it         
@echo ###############################################
timeout /t 5

cscript //nologo c:\windows\system32\slmgr.vbs /upk
cscript //nologo c:\windows\system32\slmgr.vbs /ckms
cscript //nologo c:\windows\system32\slmgr.vbs /rearm
cscript //nologo c:\windows\system32\slmgr.vbs -ato

cls
timeout /t 2
net stop sppsvc
net start sppsvc
cls

rem =======================================================================

rem ==================== End of program ====================
cls
mode con cols=50  lines=16
echo.
echo #################################################
echo     Please remember to restart the computer
echo #################################################
echo.
echo after restart
echo.
Echo to the settings of the update and security enable 
echo.
Echo Press the troubleshooting button
echo.
Echo wait for the button to enable Windows and click
echo #################################################
echo .
echo 　　Please press any key to end
pause > nul
exit
rem ==================================================

rem ==================== No system administrator rights ====================
:NoAdmin
cls
mode con cols=31 lines=3
echo.
echo 　　Please execute as a system administrator
pause > nul
exit
rem ==========================================================
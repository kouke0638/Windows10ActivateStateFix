chcp 65001
@echo OFF
@title Windows10啟用修復程序

rem ==================== 檢查系統管理員權限 ====================
cls
mode con cols=29 lines=3
echo.
echo 　　檢查系統管理員權限中
echo Administrator > %WINDIR%\System32\Administrator.txt
if not exist %WINDIR%\System32\Administrator.txt goto :NoAdmin
del /s /f /q %WINDIR%\System32\Administrator.txt > nul
rem ============================================================


rem ==================== 啟動修復 ====================
cls
mode con cols=42 lines=13


@echo ##################################
@echo        正在準備啟動修復         
@echo ##################################

timeout /t 5
net stop sppsvc
net start sppsvc
timeout /t 2

cls
@echo ###############################
@echo  稍後如果出現錯誤不用理會         
@echo ###############################
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

rem ==================== 程式結束 ====================
cls
mode con cols=50  lines=16
echo.
echo #################################################
echo               請記得重啟電腦
echo #################################################
echo.
echo                   重啟後
echo.
echo 到設定 的 更新與安全性 啟用 按下疑難排解的按鈕
echo.
echo    等待出現  啟用Windows  的按鈕並點選
echo #################################################
echo .
echo 　　請按任意鍵結束
pause > nul
exit
rem ==================================================

rem ==================== 無系統管理員權限 ====================
:NoAdmin
cls
mode con cols=31 lines=3
echo.
echo 　　請以系統管理員身份執行
pause > nul
exit
rem ==========================================================
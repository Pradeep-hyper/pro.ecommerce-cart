title BATCH FOR POST-EXAMINATION-TASK(UNINSTALL/WINDOWS_THEME_RESET/USB_ENABLE/REMOVE_OTHER_FILE/RESET_NETWORK
:-------------------------------------------------------------------------------------------------------------

:: START OF CONSOLE COLOR & SIZE
:  =============================
@echo off
color 0d
mode con cols=110 lines=50 >nul
CLS

:: END OF CONSOLE COLOR & SIZE
:  ---------------------------

:: START SECTION FOR RUN AS ADMINISTRATOR A BATCH FILE AUTOMATICALLY (FOR 32-bit & 64-bit OS)
:  ==========================================================================================
@echo off
:: BatchGotAdmin
:--------------------------------------------------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:----------------------------------------------------------------------------------------------------------
 
:: END SECTION FOR RUN AS ADMINISTRATOR A BATCH FILE AUTOMATICALLY (FOR 32-bit & 64-bit OS)
:  ----------------------------------------------------------------------------------------

:: UNINSTALL CLIENT.EXE & TinyWall ( Description will get from appwiz.cpl) & (Change as required)
:  ==============================================================================================
@echo off
sc config "TinyWall" start= disabled
net stop TinyWall /y
Stop-Service -Name "TinyWall" -Force
taskkill /f /im Tinywall.exe
echo TinyWall has been terminated.

wmic product where "description='TinyWall' " uninstall /nointeractive
wmic product where "description='MPESB_CLIENT_SETUP_2024' " uninstall /nointeractive 

:: END OF UNINSTALL CLIENT.EXE & TinyWall
:  --------------------------------------


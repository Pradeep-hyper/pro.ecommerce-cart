REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

:: START OF THIS SECTION FOR "SYSTEM/COMPUTER NAME CHANGE" AUTOMATICALLY 
:  =====================================================================
@echo off
echo.
echo "THE COMPUTER NAME IS GOING TO CHANGE :"
cls
echo\
echo =========================================
SET /P PCNAME=PLEASE ENTER YOUR DESIRED COMPUTER NAME :
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /v ComputerName /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName\ /v ComputerName /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\ /v Hostname /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\ /v "NV Hostname" /t REG_SZ /d %PCNAME% /f
echo\
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableFirstLogonAnimation /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v DisablePrivacyExperience /t REG_dword /d 1 /f
reg add hklm\system\currentcontrolset\services\tcpip6\parameters /v DisabledComponents /t REG_DWORD /d 0xFFFFFFFF /f
REG add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
netsh advfirewall reset
netsh firewall set opmode disable
netsh advfirewall set domainprofile state off
netsh advfirewall set privateprofile state off
netsh advfirewall set publicprofile state off
netsh advfirewall set allprofiles state off
REG ADD HKLM\Software\Microsoft\windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v LowRiskFileTypes /t REG_SZ /d .msi;.exe;.txt;.bat;.config /f
sc config "SysMain" start=disabled
net stop SysMain /y
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoClose /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoLogoff /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
taskkill /f /im "AA_v3.exe"
taskkill /f /im anydesk.exe
taskkill /f /im "foxit reader.exe"
taskkill /f /im "%%i"
"HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaveActive /t REG_SZ /d 0 /f
reg add "hkcu\control panel\desktop" /v wallpaper /t REG_SZ /d "" /f
reg add "hkcu\control panel\desktop" /v wallpaper /t REG_SZ /d "D:\ABC.jpg" /f
reg delete "hkcu\Software\Microsoft\Internet Explorer\Desktop\General" /v WallpaperStyle /f
reg add "hkcu\control panel\desktop" /v WallpaperStyle /t REG_SZ /d 0 /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
powercfg -x -monitor-timeout-ac 0
powercfg -x -disk-timeout-ac 0
powercfg -x -standby-timeout-ac 0 
powercfg -x -hibernate-timeout-ac 0
powercfg -setactive a1841308-3541-4fab-bc81-f71556f20b4a
powercfg -x -monitor-timeout-ac 0
powercfg -x -disk-timeout-ac 0
powercfg -x -standby-timeout-ac 0 
powercfg -x -hibernate-timeout-ac 0
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
powercfg -x -monitor-timeout-ac 0
powercfg -x -disk-timeout-ac 0
powercfg -x -standby-timeout-ac 0 
powercfg -x -hibernate-timeout-ac 0
powercfg /setacvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 0
powercfg -setacvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 0
powercfg.exe -change -monitor-timeout-ac 0
powercfg.exe -change -disk-timeout-ac 0
powercfg.exe -change -standby-timeout-ac 0
powercfg.exe -change -hibernate-timeout-ac 0
sc config wuauserv start= disabled
net stop wuauserv
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /t REG_SZ /d about:blank /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Privacy" /v ClearBrowsingHistoryOnExit /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Privacy" /v CleanForms /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Privacy" /v CleanPassword /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Privacy" /v CleanDownloadHistory /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Privacy" /v CleanTrackingProtection /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Privacy" /v ClearInPrivateFilteringData /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "SyncMode5" /t REG_DWORD /d 3 /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\New Windows" /V PopupMgr /T REG_DWORD /D 0 /F
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d no /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Use FormSuggest" /t REG_SZ /d no /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "FormSuggest Passwords" /t REG_SZ /d no /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "FormSuggest PW Ask" /t REG_SZ /d no /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "ProxyEnable" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoDetect /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "ProxyEnable" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoDetect /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "DisableCachingOfSSLPages" /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Cache" /v "Persistent" /t REG_DWORD /d 0 /f
reg add HKLM\SYSTEM\CurrentControlSet\Services\UsbStor /v "Start" /t REG_DWORD /d "3" /f
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 1 /f
netsh advfirewall firewall set rule group="Network Discovery" new enable=No
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=No
reg add "HKey_Local_Machine\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters" /v AutoShareWks /t REG_DWORD /d 0 /f
netsh interface set interface "VMware Network Adapter VMnet1" disabled
netsh interface set interface "VMware Network Adapter VMnet8" disabled
netsh interface set interface "VirtualBox Host-Only Network" disabled
netsh interface set interface "vEthernet (Default Switch)" disabled
ipconfig /flushdns
sc config "lanmanserver" start=disabled
net stop server /y
netsh interface ip delete dns "Ethernet" all
netsh interface ip delete dns "Local Area Connection" all

cd\
cd EDUKOL
Protected_Client_Setup.msi /passive
@REM timeout 10
@REM TinyWall-v3-Installer.msi /passive
@REM shutdown -r -t 15








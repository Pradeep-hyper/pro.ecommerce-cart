
@echo off
color 0a

echo "Uninstalling Tinywall Please wait......."
sc query TinyWall > nul 2>&1
if %errorlevel% == 0 (
    net stop TinyWall > nul 2>&1
    sc config TinyWall start= disabled > nul 2>&1
)
taskkill /F /IM tinywall.exe > nul 2>&1
timeout /t 5 > nul
if exist "C:\ProgramData\TinyWall\pwd" (
    attrib -r -s -h "C:\ProgramData\TinyWall\pwd"
    del "C:\ProgramData\TinyWall\pwd"
)
@echo off
wmic product where "description='TinyWall'" uninstall /nointeractive
echo "Uninstalling packages Please wait..."
 wmic product where "description ='BEL_CLIENT_SETUP_2025'" uninstall /nointeractive

echo.
echo "Enabling USB................"
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\USBSTOR /v "Start" /t REG_DWORD /d "3" /f
echo.
@echo off
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 0 /f
echo =========================================
echo "Stopping NMS................"
                taskkill /f /im "client_1.exe"
                taskkill /f /im client_2.exe
                taskkill /f /im "client_3.exe"
REM Wait for a few seconds to ensure processes are terminated
timeout /T 5 /NOBREAK
PowerShell -Command "Remove-Item -Path 'C:\NMS' -Recurse -Force"
@echo off
echo Setup completed.
echo =========================================
echo "All tasks completed successfully."
echo =========================================
shutdown -s -t 5
timeout /t 2 /nobreak

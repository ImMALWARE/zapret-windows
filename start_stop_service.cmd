@echo off
chcp 65001 >nul
cd /d "%~dp0"
IF NOT EXIST "system\" (
    echo Распакуйте архив!
    echo Unpack the archive!
    pause
    exit /b
)
sc query bfe | find "RUNNING" >nul
if errorlevel 1 (
    echo Служба BFE не запущена! Откройте "Службы" и запустите "Служба базовой фильтрации"!
    echo BFE service is not running! Open "Services" and start "Base Filtering Engine"!
    pause
    exit
)
setlocal DisableDelayedExpansion
set "batchPath=%~dpnx0"
for %%k in (%0) do set "batchName=%%~nk"
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

whoami /groups /nh | find "S-1-16-12288" >nul
if '%errorlevel%'=='0' (
  net session >nul 2>&1
  if '%errorlevel%'=='0' goto gotPrivileges
)

if '%1'=='ELEV' shift /1 & goto gotPrivileges

> "%vbsGetPrivileges%" (
  echo Set UAC = CreateObject^("Shell.Application"^)
  echo args = "ELEV "
  echo For Each strArg in WScript.Arguments
  echo args = args ^& strArg ^& " "
  echo Next
  echo args = "/c """ + "%batchPath%" + """ " + args
  echo UAC.ShellExecute "%SystemRoot%\System32\cmd.exe", args, "", "runas", 1
)

"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & cd /d %~dp0
if '%1'=='ELEV' del "%vbsGetPrivileges%" >nul 2>&1 & shift /1



sc query ZapretService >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    taskkill /f /im "winws.exe"
    sc stop "ZapretService"
    sc delete "ZapretService"
    sc stop "WinDivert"
    echo .
    echo Служба zapret удалена. Вы можете закрыть эту командную строку.
    echo Для запуска службы запустите этот же файл.
    echo The zapret service has been removed. You can close this command prompt.
    echo To start the service, run this same file.
    pause > nul
    exit
)

set "autohosts="%~dp0autohosts.txt""
set "ignore="%~dp0ignore.txt""
set "youtube="%~dp0youtube.txt""
set "quicgoogle="%~dp0system\quic_initial_www_google_com.bin""
set "tlsgoogle="%~dp0system\tls_clienthello_www_google_com.bin""

set "args="

for /f "usebackq delims=" %%A in ("config.txt") do (
    set "line=%%A"
    set "line=!line:{hosts}=%autohosts%!"
    set "line=!line:{ignore}=%ignore%!"
    set "line=!line:{youtube}=%youtube%!"
    set "line=!line:{quicgoogle}=%quicgoogle%!"
    set "line=!line:{tlsgoogle}=%tlsgoogle%!"
    set "args=!args! !line!"
)

sc create "ZapretService" binPath= "\"%CD%\system\winws.exe\" !args!" DisplayName= "ZapretService" start= auto
sc description "ZapretService" "Ускорение устаревших серверов"
sc start "ZapretService"

echo .
echo zapret запущен в фоне. Вы можете закрыть эту командную строку.
echo Для остановки службы запустите этот же файл.
echo zapret is running in the background. You can close this command prompt.
echo To stop the service, run this same file.
pause > nul
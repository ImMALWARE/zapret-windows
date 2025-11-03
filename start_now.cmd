@echo off
chcp 65001 >nul
cd /d "%~dp0"
IF NOT EXIST "system\" (
    echo Распакуйте архив!
    pause
    exit /b
)
setlocal enabledelayedexpansion

sc query bfe | find "RUNNING" >nul
if errorlevel 1 (
    echo Служба BFE не запущена! Откройте "Службы" и запустите "Служба базовой фильтрации"!
    pause
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

start "zapret t.me/immalware" "system\winws.exe" !args!
@echo off
chcp 65001 >nul
cd /d "%~dp0"
setlocal enabledelayedexpansion

set "autohosts="%~dp0autohosts.txt""
set "youtube="%~dp0youtube.txt""
set "quicgoogle="%~dp0system\quic_initial_www_google_com.bin""
set "tlsgoogle="%~dp0system\tls_clienthello_www_google_com.bin""

set "args="

for /f "usebackq delims=" %%A in ("config.txt") do (
    set "line=%%A"
    set "line=!line:{hosts}=%autohosts%!"
    set "line=!line:{youtube}=%youtube%!"
    set "line=!line:{quicgoogle}=%quicgoogle%!"
    set "line=!line:{tlsgoogle}=%tlsgoogle%!"
    set "args=!args! !line!"
)

start "zapret t.me/immalware" "system\winws.exe" !args!
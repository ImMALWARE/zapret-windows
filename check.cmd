@echo off
chcp 65001 >nul
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


reg add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d Unrestricted /f

powershell system/checker.ps1
pause
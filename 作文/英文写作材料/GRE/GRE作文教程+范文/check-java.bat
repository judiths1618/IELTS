@echo off

reg.exe query "HKLM\Software\JavaSoft\Java Runtime Environment" /v "CurrentVersion" > nul 2> nul
if errorlevel 1 goto NotInstalled

rem Retrieve installed version number.
rem The reg.exe output parsing found at http://www.robvanderwoude.com/ntregistry.php
set JvmVersion=
for /F "tokens=3* delims= " %%A IN ('reg.exe query "HKLM\Software\JavaSoft\Java Runtime Environment" /v "CurrentVersion"') do set JvmVersion=%%A
rem if "%JvmVersion%" == "" goto NotInstalled

:Installed
setlocal
set RequiredVersion=8

echo Your Java version is %JvmVersion%
echo Required Java version is 1.8
echo.

for /f "tokens=3" %%g in ('java -version 2^>^&1 ^| findstr /i "version"') do (
    REM @echo Output: %%g
    set JAVAVER=%%g
)

for /f "delims=. tokens=1-3" %%v in ("%JvmVersion%") do (
    REM @echo Major: %%v
    REM @echo Minor: %%w
    REM @echo Build: %%x
	set CurVersion=%%w
)

if %CurVersion% GEQ %RequiredVersion% (
	echo You have the latest Java version. Please enjoy the app.
	goto End
)

endlocal

goto EndUpdateJava

:NotInstalled
echo Java Runtime Environment not installed.
goto EndUpdateJava


REM @echo off
REM setlocal

REM set VERSION6="1.6.0_21"
REM for /f "tokens=3" %%g in ('java -version 2^>^&1 ^| findstr /i "version"') do (
    REM @echo Output: %%g
    REM set JAVAVER=%%g
REM )
REM set JAVAVER=%JAVAVER:"=%
REM @echo Output: %JAVAVER%

REM for /f "delims=. tokens=1-3" %%v in ("%JAVAVER%") do (
    REM @echo Major: %%v
    REM @echo Minor: %%w
    REM @echo Build: %%x
REM )

REM endlocal

:EndUpdateJava
echo Please download latest Java SE Runtime Environment. You can google "Download Java SE Runtime Environment" or 百度 “下载java运行环境”

:End
echo.
pause
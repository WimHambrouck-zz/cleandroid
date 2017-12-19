@rem  ##########################################################################
@rem
@rem  Export an ANDROID STUDIO application 
@rem
@rem  ##########################################################################
echo off
IF "%~1"=="" (GOTO BEGIN) ELSE (set /p dirname=%1)
GOTO EXPORT
:BEGIN
CLS
echo =========================================
echo ANDROID STUDIO files sources export
echo =========================================
echo.
set /p dirname="Dir name to export: "
if %dirname% == "" goto ERROR
:EXPORT
REM set MYDIR=%dirname:~0,-1%
for %%f in (%dirname%) do set str=%%~nxf
echo %str%
REM set str=%dirname%
IF NOT EXIST C:\EXPORT\%str%\NUL (GOTO MAKEDIR)
RMDIR /S /Q C:\EXPORT\%str%
:MAKEDIR
mkdir c:\EXPORT\%str%
pause
xcopy %dirname% c:\EXPORT\%str% /s
del c:\EXPORT\%str%\*.iml
del c:\EXPORT\%str%\app\*.apk
rmdir c:\EXPORT\%str%\.gradle /s /q 
rmdir c:\EXPORT\%str%\.idea /s /q 
rmdir c:\EXPORT\%str%\build /s /q 
erase c:\EXPORT\%str%\app\build /f /s /q
rmdir c:\EXPORT\%str%\app\build /s /q 
goto END
:ERROR
echo Cannot create, check the directory root
goto OUT
:END
CLS
echo =========================================
echo  ANDROID STUDIO EXPORT
echo =========================================
echo Export ended, check c:\EXPORT
choice /M "Export another? "
IF ERRORLEVEL 2 GOTO OUT
IF ERRORLEVEL 1 GOTO BEGIN
:OUT
start C:\EXPORT
@rem  ##########################################################################
@rem
@rem  Export an ANDROID STUDIO application 
@rem
@rem  ##########################################################################
echo off
IF "%~1"=="" (GOTO BEGIN) ELSE (set dirname=%1)
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
SET exdir=C:\EXPORT
REM set MYDIR=%dirname:~0,-1%
for %%f in (%dirname%) do set str=%%~nxf
echo %str%
REM set str=%dirname%
IF NOT EXIST %exdir%\%str%\NUL (GOTO MAKEDIR)
RMDIR /S /Q %exdir%\%str%
:MAKEDIR
mkdir %exdir%\%str%
pause
xcopy %dirname% %exdir%\%str% /s
del %exdir%\%str%\*.iml
del %exdir%\%str%\app\*.apk
rmdir %exdir%\%str%\.git /s /q
rmdir %exdir%\%str%\.gradle /s /q 
rmdir %exdir%\%str%\.idea /s /q 
rmdir %exdir%\%str%\build /s /q 
erase %exdir%\%str%\app\build /f /s /q
rmdir %exdir%\%str%\app\build /s /q 
goto ZIP
:ERROR
echo Cannot create, check the directory root
goto OUT
:ZIP
REM choice /M "Zip project? "
REM IF ERRORLEVEL 2 GOTO END
7z a -tzip %exdir%\%str%.zip %exdir%\%str%
:END
CLS
echo =========================================
echo  ANDROID STUDIO EXPORT
echo =========================================
echo Export ended, check %exdir%
choice /M "Export another? "
IF ERRORLEVEL 2 GOTO OPENDIR
IF ERRORLEVEL 1 GOTO BEGIN
:OPENDIR
start %exdir%
:OUT
echo.
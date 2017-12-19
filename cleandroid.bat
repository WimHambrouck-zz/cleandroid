@rem  ##########################################################################
@rem
@rem  Export an ANDROID STUDIO application 
@rem
@rem  ##########################################################################
echo off
IF "%1"=="/?" GOTO HELP
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
GOTO OUT
:HELP
echo Copies and cleans an Android Studio Project
echo.
echo CLEANDROID [path] [/K:name1[+name2][+name3]...] [/D] [/E folder]
echo.
echo  path			The path to the project. If no path is specified, you'll be asked on launch.
echo  /K:git, /keepgit	Does not delete the project's git repository (.git folder)
echo  /K:idea, /keepidea	Does not delete the IntelliJ project files (.idea folder)
echo  /D, /debug		Verbose output + script pauzes before every operation
echo  /E folder		Export to specified folder (default: C:\EXPORT)
echo.
:OUT
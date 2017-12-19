@rem  ##########################################################################
@rem
@rem  Export an ANDROID STUDIO application 
@rem
@rem  ##########################################################################
echo off
REM FIND returns an ErrorLevel 1 if "test string" isn't found in the input, or 0 if it is (if the test string is equal to the input, but also if the test string is part of the input).
:START
FOR %%A IN (%~*) DO (
	ECHO "%%A"| FIND /I """/E"""
	IF ERRORLEVEL 1 (SET /P exdir=C:\EXPORT)
	IF ERRORLEVEL 0 GOTO CHEXPORT
	
	
	IF "%%A"=="/E"
	IF "%~1"=="" GOTO BEGIN
	IF "%1"=="/?" GOTO HELP
)
set /p dirname=%1
GOTO EXPORT
:CHEXPORT
set /p exdir=%%A
SHIFT
GOTO START
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
REM pause
xcopy %dirname% c:\EXPORT\%str% /s
del c:\EXPORT\%str%\*.iml
del c:\EXPORT\%str%\app\*.apk
rmdir c:\EXPORT\%str%\.git /s /q
rmdir c:\EXPORT\%str%\.gradle /s /q 
rmdir c:\EXPORT\%str%\.idea /s /q 
rmdir c:\EXPORT\%str%\build /s /q 
erase c:\EXPORT\%str%\app\build /f /s /q
rmdir c:\EXPORT\%str%\app\build /s /q 
goto ZIP
:ERROR
echo Cannot create, check the directory root
goto OUT
:ZIP
choice /M "Zip project? "
IF ERRORLEVEL 2 GOTO END
7z a -tzip C:\EXPORT\%str%.zip C:\EXPORT\%str%
:END
CLS
echo =========================================
echo  ANDROID STUDIO EXPORT
echo =========================================
echo Export ended, check c:\EXPORT
choice /M "Export another? "
IF ERRORLEVEL 2 GOTO OPENDIR
IF ERRORLEVEL 1 GOTO BEGIN
:OPENDIR
start C:\EXPORT
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

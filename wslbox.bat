@echo off
rem Check if wsl is installed first
if not exist %WINDIR%\system32\wsl.exe goto :noWSL

rem check to see if called as wslbox, or if renamed
rem echo %~n0
IF "%~n0" == "wslbox" (
	rem if wslbox is run with no parms, display usage
	if "%1" == "" (
		echo Usage: wslbox [function [arguments]...]
		echo or: function [arguments]... if linked as function wslbox will perform as the link is named
		echo or wslbox /install /uninstall /list
		pause
	) else if "%1" == "/install" (
		echo install dir must be in path for optimal use
		pause
		for /F "tokens=1" %%A in (linuxcommands.txt) do mklink %%A.bat wslbox.bat
	) else if "%1" == "/uninstall" (
		echo for safety after this is run uninstall.bat will be created, you can then run that file to uninstall
		pause
		del uninstall.bat
		for /F "tokens=1" %%A in (linuxcommands.txt) do echo del %%A.bat >> uninstall.bat
	) else if "%1" == "/list" (
		type linuxcommands.txt
	) else (
	rem if called as wslbox without listed args run like wsl
	wsl %*
	)
) else (
	REM if called as a link, execute wsl then basename then args
	wsl %~n0 %*
)
goto :eof
:noWSL
echo you must install Windows Subsystem for Linux from Control Panel and download a distro before using wslbox
pause
:eof

REM renamed links need to have an executable extension for example pwd.bat
REM To create use mklink pwd.bat wslbox.bat
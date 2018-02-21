@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
SET path="C:\PortableApps\SecureCRT 8.0\SessionLogs"
SET zip="C:\Program Files\7-Zip\7z.exe"
echo %path%
REM This searches the filenames within the %path% declared above
FOR /f %%I in ('dir /b %path%\*.log') DO (
	REM ### Expands %I to file name (~n) and extension (~x) >> can join (~nx)
	set logfile=%%~nxI
	REM ### echo.Logname : !logfile!
	REM ### Using "delims=_" to extract the hostname (hostname is the first string before the underscore "_")
	FOR /f "delims=_" %%a in ("!logfile!") DO (
		set hostname=%%a
		REM ### echo.Hostname: !hostname!
		REM ### Actual 7z command: Updates (u), and maximum compression (-mx9)
		%zip% u -mx9 %path%\!hostname!.7z %path%\!logfile!
	)
)

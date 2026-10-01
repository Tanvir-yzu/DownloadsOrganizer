@echo off
setlocal EnableExtensions
title Downloads Organizer

:: Go to the folder where this BAT file is located
cd /d "%~dp0"

:: Store this BAT file name
set "self=%~nx0"

:: Organize files by extension
call :m "Videos" mp4 mkv avi mov wmv flv webm 3gp
call :m "Photos" jpg jpeg png gif bmp webp heic svg
call :m "Documents" pdf doc docx xls xlsx csv ppt pptx
call :m "Txt Files" txt
call :m "Music" mp3 wav aac flac m4a ogg
call :m "Zip" zip rar 7z tar gz
call :m "Apps" exe msi apk

:: Move remaining files to Others
for %%f in (*) do (
    if /i not "%%~nxf"=="%self%" (
        if /i not "%%~xf"==".crdownload" (
            if /i not "%%~xf"==".part" (
                if /i not "%%~xf"==".tmp" (
                    if not "%%~xf"=="" (
                        if not exist "Others" md "Others"

                        if not exist "Others\%%~nxf" (
                            move "%%f" "Others\" >nul
                        )
                    )
                )
            )
        )
    )
)

echo.
echo ==========================================
echo       Downloads Organizer Completed
echo ==========================================
echo.
echo Your Downloads folder has been organized.
echo.
pause
exit /b


:: ==================================================
:: Function: Move files based on extension
:: Usage:
:: call :m "Folder Name" ext1 ext2 ext3
:: ==================================================

:m
set "d=%~1"
shift

:next_extension
if "%~1"=="" exit /b

:: Check whether files with this extension exist
if exist "*.%~1" (

    :: Create destination folder if needed
    if not exist "%d%" md "%d%"

    :: Move matching files
    for %%f in ("*.%~1") do (
        if exist "%%~f" (
            if not exist "%d%\%%~nxf" (
                move "%%~f" "%d%\" >nul
            )
        )
    )
)

shift
goto next_extension
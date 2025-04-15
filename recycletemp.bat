:: Set name for temporary folder
set tempFolderName=Temporary
:: The folder with the name below will not be deleted
set saveFolderName=saveme
:: 0 = move to trash, 1 = remove permanently
set removePermanently=0
:: end of user input

:: This file needs trash-cli to run: https://www.npmjs.com/package/trash-cli
:: npm install --global trash-cli
:: If not available: change this setting to remove the files permanently

::Put this file or a shortcut to it in "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup" to run on startup

:: Generate backup folder name
set sanitizedDate=%DATE:/=_%
set sanitizedTime=%TIME::=_%
set recycleName=%tempFolderName%_%sanitizedDate:~3,11%_%sanitizedTime:~0,8%

:: Create the subfolder inside tempFolder so when the folder is restored, it will be inside the original
md "%userprofile%\%tempFolderName%\%recycleName%"

:: Move all files and folders except saveme and desktop.ini to the subfolder
for /f "delims=" %%F in ('dir /b /a-d "%userprofile%\%tempFolderName%"') do (
    if /i not "%%F"=="desktop.ini" move "%userprofile%\%tempFolderName%\%%F" "%userprofile%\%tempFolderName%\%recycleName%"
)
for /f "delims=" %%D in ('dir /b /ad "%userprofile%\%tempFolderName%"') do (
    if /i not "%%D"=="%saveFolderName%" move "%userprofile%\%tempFolderName%\%%D" "%userprofile%\%tempFolderName%\%recycleName%"
)

if "%removePermanently%"=="1" (
    :: permanently delete folder
    rd "%userprofile%\%tempFolderName%\%recycleName%" /s /q
) else (
    :: move folder to trash
    trash "%userprofile%\%tempFolderName%\%recycleName%"
)

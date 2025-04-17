:: Set names for temporary folder and the saveme folder (doesn't get deleted)
set tempFolderName=Tijdelijk
set saveFolderName=saveme

:: Generate backup folder name
set timeHour=%TIME: =0%
set recycleName=%tempFolderName%_%DATE:~8,2%_%DATE:~3,2%_%DATE:~0,2%_%timeHour:~0,2%_%TIME:~3,2%

:: Copy your temporary folder to %temp% with generated name
move "%userprofile%\%tempFolderName%" "%temp%\%recycleName%"

:: Remake your temporary folder and add ini file and saveme folder
md "%userprofile%\%tempFolderName%"
attrib +r "%userprofile%\%tempFolderName%"
xcopy /H /K "%temp%\%recycleName%\desktop.ini" "%userprofile%\%tempFolderName%"
move "%temp%\%recycleName%\%saveFolderName%" "%userprofile%\%tempFolderName%"

:: Move folder back from temp to your temporary folder, in case you want to restore it from recycle bin later, before removing it
move "%temp%\%recycleName%" "%userprofile%\%tempFolderName%\%recycleName%"
recycle "%userprofile%\%tempFolderName%\%recycleName%"


:: Clearing temp folder
rd %temp% /s /q
md %temp%

:: This file needs recycle.exe from cmdutils (http://www.maddogsw.com/cmdutils/) in system32 to run.
:: If recycle.exe not available: use cleartemp.bat

::Put this file or a shortcut to it in "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup" to run on startup
:: If you want to keep files make a saveme folder in your temporary folder

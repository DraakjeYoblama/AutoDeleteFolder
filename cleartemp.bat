:: Set names for temporary folder and the saveme folder (doesn't get deleted)
set tempFolderName=Tijdelijk
set saveFolderName=saveme
:: If you want to keep files make a saveme folder in your temporary folder

:: Generate folder to be deleted
set timeHour=%TIME: =0%
set recycleName=%tempFolderName%_%DATE:~8,2%_%DATE:~3,2%_%DATE:~0,2%_%timeHour:~0,2%_%TIME:~3,2%

:: Copy your temporary folder to %temp% with generated name
move "%userprofile%\%tempFolderName%" "%temp%\%recycleName%"

:: Remake your temporary folder and add ini file and saveme folder
md "%userprofile%\%tempFolderName%"
attrib +r "%userprofile%\%tempFolderName%"
xcopy /H /K "%temp%\%recycleName%\desktop.ini" "%userprofile%\%tempFolderName%"
move "%temp%\%recycleName%\%saveFolderName%" "%userprofile%\%tempFolderName%"

:: permanently delete folder
::rd "%temp%\%recycleName%" /s /q

:: clear temp folder and permanently delete folder
rd %temp% /s /q
md %temp%

::Put this file or a shortcut to it in "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup" to run on startup

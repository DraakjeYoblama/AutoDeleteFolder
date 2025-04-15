# AutoDeleteFolder

Batch file to delete contents of a certain folder, which is located in your user folder (C:\Users\username)

## batch file

**recycletemp.bat** puts the files from your temporary folder in the recycle bin, contained in a seperate folder marked with the time and date.
To use this you need to install [trash-cli](README.md#how-to-get-trashcli), a small command line tool

if you can't install trash-cli, you can change the start of the file `set removePermanently=1` to remove files permanently instead

You can choose the name of the that gets deleted with `set tempFolderName=Temporary`

You can choose a folder that will be saved from deletion with `set saveFolderName=saveme`

## If you want to run on startup

You have to put your chosen file in
~~~ 
C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup
~~~

## If you want to run with the cmd window hidden:
- Make shortcut to the .bat file
- Right click the shortcut and select properties
- Under Run: choose minimised
- Now use the shortcut instead of the original file

If you put the shortcut in the startup folder, make sure the original file isn't in there too, or you'll run it twice.

## How to get recycle.exe

Get [trash-cli](https://www.npmjs.com/package/trash-cli) from [npm](https://nodejs.org/en) by running `npm install --global trash-cli`

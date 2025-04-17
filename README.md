# AutoDeleteFolder

Batch file to delete contents of a certain folder, located in your user folder (%userprofile%)

## Should I use recycletemp.bat or cleartemp.bat?

**recycletemp.bat** puts the files from your temporary folder in the recycle bin in a seperate folder marked with the time and date.
To use this you need to download [recycle.exe](README.md#how-to-get-recycleexe), a small command line tool

**cleartemp.bat** irreversibly deletes your files

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

- Get [cmdutils.zip](http://www.maddogsw.com/cmdutils/cmdutils.zip) from [http://www.maddogsw.com/cmdutils/](http://www.maddogsw.com/cmdutils/)
- Extract recycle.exe from the zip, you don't need the other files
- Move recycle.exe to C:\Windows\System32

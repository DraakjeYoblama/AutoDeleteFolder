# AutoDeleteFolder

Cross-platform Python script to delete contents of a specified folder. Files can either be deleted permanently, moved to trash, or moved to a timestamped subfolder. One specified subfolder and earlier backups will be saved from deletion.

I created this script to run on startup, the default settings are the ones I use.

## Script setup

**autodeletefolder.py** has a few variables to set up.

`temp_folder_name = r"Temporary"` is the folder of which the contents are to be deleted. By default, the folder will be in the home folder at `C:\Users\me\Temporary` (Windows) or `/home/me/Temporary` (Linux). The script expects this folder to already exist. You can also give a full path to any folder e.g. `temp_folder_name = r"C:\any\folder"`.

`save_folder_name = "saveme"` is the folder inside the temp folder to be saved. Its contents will not be deleted when the script runs. Essentially it behaves like a normal folder. If you don't want this behaviour, set to `save_folder_name = None` or delete the variable.

`deletion_level = 1` 0 = delete permanently, 1 = move to trash, 2 = move to timestamped subfolder. If you select option 1, you need to install the [send2trash](README.md#dependencies) Python package.

`timestamp_format = "%y-%m-%d_%H-%M"` format for timestamp in trash folder name. Only used if deletion_level is 1 or 2. Uses Python [strftime format](https://www.bairesdev.com/tools/strftime/).


### Dependencies

To send files to trash/recycle bin, install the Python package **send2trash** using `pip install send2trash`. 

## How to run

If you have Python installed and set to open .py files, you can just click on this script to run it. Below is a guide to run the script at startup.

### Windows

1. Create a shortcut to autodeletefolder.py
2. Open shortcut file properties
3. Edit *Target* to `python "C:\path\to\autodeletefolder.py"` (change to the correct path)
4. (optional) Set *Run* to `minimised`
5. add this shortcut to startup at `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup`

You can also use task scheduler for more options.

### Linux

1. Create a new cronjob using `sudo crontab -e`
2. add `@reboot python /path/to/autodeletefolder.py &` to the bottom of the file (change to the correct path)

You can also use a systemd service.
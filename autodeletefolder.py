import os
import shutil
import time
from pathlib import Path
import subprocess
import platform

# ==========================
# CONFIG VARIABLES
# ==========================
temp_folder_name = r"Temporary"   # folder name in home directory or full path to temp folder
save_folder_name = "saveme"       # folder inside temp folder to preserve, None to disable
deletion_level = 1               # 0 = delete permanently, 1 = move to trash, 2 = move to timestamped subfolder
timestamp_format = "%y-%m-%d_%H-%M"   # format for timestamp in trash folder name
# ==========================


IS_WINDOWS = platform.system() == "Windows"
IS_LINUX = platform.system() == "Linux"
IS_MAC = platform.system() == "Darwin"

def resolve_temp_path(name: str) -> Path:
    p = Path(name)
    if p.is_absolute():
        return p
    return Path.home() / name

# Lazy initialization of trash path
trash_path = None
def get_trash_path(temp_path):
    global trash_path

    if trash_path is None:
        timestamp = time.strftime(timestamp_format)
        trash_name = f"{temp_path.name}_{timestamp}"
        base_path = temp_path / trash_name
        trash_path = base_path

        # Ensure unique folder name by appending a counter if needed
        counter = 1
        while trash_path.exists():
            trash_path = temp_path / f"{trash_name}_{counter}"
            counter += 1

        trash_path.mkdir()
        print(f"Creating trash folder: {trash_path}")

        if IS_WINDOWS:
            # Copy desktop.ini if it exists
            desktop_ini = temp_path / "desktop.ini"
            if desktop_ini.exists():
                shutil.copy2(desktop_ini, trash_path / "desktop.ini")
                subprocess.run(["attrib", "+s", str(trash_path)], shell=True)

    return trash_path

# Cross-platform recycle bin (best effort)
def send_to_recycle_bin(path: Path):
    try:
        from send2trash import send2trash
    except ImportError:
        raise RuntimeError("send2trash module required: pip install send2trash")

    send2trash(str(path))


def main():
    temp_path = resolve_temp_path(temp_folder_name)

    if not temp_path.exists():
        print(f"Temp folder does not exist: {temp_path}")
        return

    # if save_folder_name is None or non-existent, no folder is saved.
    save_name = globals().get("save_folder_name")
    save_path = temp_path / save_name if save_name else None

    for item in temp_path.iterdir():
        # Skip the save folder
        if save_path and item == save_path:
            continue

        # Skip the timestamped folder
        if trash_path and item == trash_path:
            continue

        # Skip desktop.ini files so that e.g. folder icons are preserved
        if IS_WINDOWS and item.name.lower() == "desktop.ini":
            continue

        # Skip any previous timestamped folders
        if item.is_dir() and item.name.startswith(f"{temp_path.name}_"):
            continue

        try:
            if deletion_level == 0:
                if item.is_file() or item.is_symlink():
                    item.unlink()
                elif item.is_dir():
                    shutil.rmtree(item)
            else:
                shutil.move(str(item), str(get_trash_path(temp_path) / item.name))

        except Exception as e:
            print(f"Error handling {item}: {e}")

    # Finally move the timestamp folder to recycle bin
    if deletion_level == 1 and trash_path and trash_path.exists():
        send_to_recycle_bin(trash_path)
        print(f"Deleted trash folder: {trash_path}")

    print("Done.")


if __name__ == "__main__":
    main()
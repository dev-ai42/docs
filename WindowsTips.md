## Some Tips for Windows Users

### Setting up WSL
Here are some tips and solutions to common problems that Windows users might run into while getting their environment setup. You might have have been using gitbash, but it's recommended everyone eventually get setup with Windows Subsystem for Linux (WSL). WSL is essentially a full, real Linux distribution running inside a special lightweight virtual machine. Because of this, basically all commands you learn about should work. Gitbash on the other hand tries to fake being a Linux system and might not work with every command. 

Setting up WSL should be fairly straightforward by following the instructions in the link below:

https://learn.microsoft.com/en-us/windows/wsl/install.

After successfully installing, you will have a Linux distribution that you will be able to interact with through the command line. (The default shell and distribution should be bash on Ubuntu if you didn't configure anything when installing). You should be able to start this directly from the start menu, or through the Windows Terminal or Powershell. You should also be able to use the WSL shell in the VSCode terminal.

Your WSL system will be somewhat separated from the rest of your Windows system, but you should still be able to interact with the existing files and programs in your Windows system. When working in the WSL shell, the rest of your windows filesystem should be on `/mnt/c`. By default, WSL should start the shell in your home directory `/home/<your_username>`, which might also be denoted by `~`. This folder should be initiallty empty. From the Windows perspective, your Linux filesystem is at `\\wsl$`. You should try to navigate to this in your Windows File Explorer (you might need to type the path directly if you can't find it on the sidebar) and pin it for easy access later.

### Linking to Windows
A lot of the labs involve interacting with the Downloads folder on your computer (e.g. to get the PEM files for SSH). Your browswer will usually download everything by default to your Downloads folder in Windows. Instead of nagivating to this folder from your Linux home everytime you want to do something, we can set up a symbolic link to the Windows Downloads folder in our Linux home directory. The command is `ln -s <path_to_windows_downloads_folder> <name_for_link>`. Depending on the exact path to the Windows folder, the full command might look something like this: `ln -s /mnt/c/Users/<your_username>/Downloads Downloads`. Now you should have a file in your home folder that allows you to access your Downloads folder in Windows as if it was a direct subfolder. You can link other folders you might want to access easily like your Desktop or Documents as well.

### Fixing Permissions
We often have to change the permissions of files before we do something. For example, we make `ssh` PEM files read-only before we can use them, and we need to make scripts executable before we can run them. You might be having issues changing permissions of some files with `chmod` in WSL since the permissions system in Windows is different from Linux. To fix this, add the following lines to your `/etc/wsl.conf` file (if it doesn't exist then create it). You might have have to use `sudo` to be able to modify files in `/etc`. This should allow Windows files to behave as if they have Linux permissions.
```
[automount]
options = "metadata"
```
After this, you might need to restart your machine for the new settings to apply.

### Fixing VSCode
On the bottom blue bar of VSCode, there should be a section that says either `LF` or `CRLF`, which stands for either line feed or carriage return line feed. On Linux and macOS, the default setting should be `LF`. On Windows, the default setting might be `CRLF`, which adds a special character called a carriage return at the end of lines. This will cause issues when trying to run bash scripts written with VSCode.
(Note that if you use command line based editors from the WSL terminal, like `nano` or `vi`, then Unix line endings will be used and you will be able to run them without any issue as long as they are executable). To change the setting, click on the `CRLF` button and change it to `LF`. This should change the setting for the current file. However, new files that you create might still be using `CRLF`. To fix this, go to 'Settings' (gear icon in lower left of screen). This should open up a tab with settings. In the sidebar on the settings tab, look for 'File', and select it. There should be a setting called 'Eol' (end of line). Change that setting through the dropdown to '\n', which corresponds to `LF` line endings.

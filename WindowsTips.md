## Some Tips for Windows Users

### Setting up WSL
Here are some tips and solutions to common problems that windows users might run into while getting their environment setup. You might have have been using gitbash, but it's recommended everyone eventually get setup with Windows Subsystem for Linux (WSL). WSL is essentially a full, real Linux distribution running inside a special lightweight virtual machine. Because of this, basically all commands you learn about should work. Gitbash on the other hand tries to fake being a Linux system and might not work with every command. 

Setting up WSL should be fairly straightforward by following the instructions in the link below:

https://learn.microsoft.com/en-us/windows/wsl/install.

After successfully installing, you will have a Linux distribution that will should be able to interact with through the command line. (The default shell and distribution should be bash on Ubuntu). You should be able to start this directly from the start menu, or through the Windows Terminal or Powershell. You should also be able to use the WSL shell in the VSCode terminal.

Your WSL system will be somewhat separated from the rest of your Windows system, but you should still be able to interact with the already existing files and programs in your Windows system. When working in the WSL shell, the rest of your windows filesystem should be on `/mnt/c`. By default, WSL should start the shell in your home directory `/home/<your_username>`, which might also be denoted by `~`. This folder should be initiallty empty. From the Windows perspective, your Linux filesystem is at `\\wsl$`. You should try to navigate to this in your Windows File Explorer (you might need to type the path directly if you can't find it on the sidebar) and pin it for easy access later.

A lot of the labs involve interacting with the Downloads folder on your computer (e.g. to get the PEM files for SSH). Your browswer will usually download everything by default to your Downloads folder in Windows. Instead of nagivating to this folder from your Linux home everytime you want to do something, we can set up a symbolic link to the Windows Downloads folder in our Linux home directory. The command is `ln -s <path_to_windows_downloads_folder> <name_for_link>`. Depending on the exact path to the Windows folder, the full command might look something like this: `ln -s /mnt/c/Users/<your_username>/Downloads Downloads`. Now you should have a file in your home folder that allows you to access your Downloads folder in Windows as if it was a direct subfolder.


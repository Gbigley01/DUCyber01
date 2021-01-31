## Solution Guide: Introduction to Scripting

Completing this activity required the following steps:

- Creating a directory to hold your scripts in `~/Security_scripts`. Then, move into this directory.

- Writing shell script `backup.sh` to automate archives and backups.

- Writing shell script `update.sh` to automate software package updates and removal.

- Writing shell script `cleanup.sh` to automate the cleanup of cached files and generate a report of system resource usage.

- Testing the scripts by running them with bash using the `sudo ./<name of the script>.sh` command.

### Solutions

Begin by creating a directory to hold your scripts in `~/Security_scripts`. Then move into this directory.

  - `mkdir -p ~/Security_scripts`  

  - `cd ~/Security_scripts`

Create a file called `backup.sh`. Write a script that does the following:

  - Creates a tar archive of `/home`. Save this to `/var/backup/home.tar`.
    
  - Moves the file `/var/backup/home.tar` to `/var/backup/home.last.tar`. This allows you to save both the last backup you made, and the one you'll make now.

  - Lists all files in `/var/backup`, including file sizes, and saves the output to `/var/backup/file_report.txt`. `ls -lh` or `ls -lah`  is useful for this task.

  - Prints how much memory your machine has free. Save this to a file called `/var/backup/disk_report.txt`. `free -h` is useful for this task.

[See `backup.sh` for the complete script](backup.sh).

Create a file called `update.sh`. Write a script that does the following:
  - Updates `apt`.
  - Runs the command to upgrade all installed packages.
  - Runs the command to install new packages and upgrade the system.
  - Runs the command to remove unneeded packages and their associated configurations.
  - **Bonus** Add line to the bottom of `update.sh` that combines all of the commands with a single line of code.
 
[See `update.sh` for the complete script](update.sh).

Create a file called `cleanup.sh`. Write a script that does the following:

  - Removes all files in `/tmp` and `/var/tmp`.
  - Clears the `apt` cache.
  - Cleans the `thumbnails` cache.

[See `cleanup.sh` for the complete script](cleanup.sh). 
  
Make each of these custom scripts executable.

- Run the following commands at the command prompt as follows:
 
  `chmod +x backup.sh`  
  `chmod +x update.sh`  
  `chmod +x cleanup.sh`
  
Test the scripts by running them with bash using the `sudo ./<name of the script>.sh` command.

**Note** that because we are interacting with system directories and processes such as `apt`, we need to use `sudo` for our scripts.

- Run the following commands:

 - `sudo ./backup.sh`

    - **Note:** When testing `backup.sh`, stop the script with `Ctrl + C`. Otherwise, it will take a long time to create a full backup of `/home`. We just want to see that it successfully runs. 

- `sudo ./cleanup.sh`

- `sudo ./update.sh`

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  
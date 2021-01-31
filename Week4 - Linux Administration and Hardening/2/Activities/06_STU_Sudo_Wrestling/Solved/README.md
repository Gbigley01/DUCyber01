## Solution Guide: `Sudo` Wrestling

- Print the name of your current user to the terminal.
  - Run `whoami`

- Determine what sudo privileges the admin user has.
  - Run `sudo -l`

- Record in a text document inside your research folder what `sudo` access the users on the system have.
  - Run  `sudo -lU <username>  >> ~/research/sudo_access.txt`

- Audit each user's files to look for anything suspicious. Don't forget about hidden files.
  - Run `ls -a /home/<username>` 
  - You should find: `home/jack/Documents/.my_files/listen.sh`.

- Document anything you find in a text file inside your research folder.
  - Run: `nano ~/research/sudo_access.txt`


- Find a user that has `sudo` access for the `less` command and complete the following:
  - Run: `sudo -lU <username>`

- Switch to that user using the password you found in the previous activity.
  - Run: `sudo su max` (password: `welcome`)

- Verify the vulnerability by dropping from `less` into a root shell.
  - Run `sudo less shopping_list.txt` _then_ `!bash`.

- Exit back to the command line.
  - Run `exit` to exit back into `less`. Run `q` to quit `less`.

- Search this user's files for anything suspicious.
  - Run: `ls -a /home/max` to reveal a copy of `.rev_shell.sh`.

- Exit that user.
  - Run: `exit`


- From the sysadmin user, switch to the root user.
  - Run: `sudo su`

- Read the `sudoers` file to see if there are any users listed with `sudo` privileges.
  - Run: `sudo less /etc/sudoers`

- Edit the `sudoers` file so that only the admin user has access.
  - Run `visudo` and remove user `max` from `sudo` access.
  
  - You should remove the following line:

    ```bash
    max  ALL=(ALL) /usr/bin/less
    ```
  
- Check that your changes to the `sudoers` file worked.
  - Run `su max` _and_ attempt `sudo less somefile`.


**TroubleShooting:** If the `sudoers` file becomes damaged, it could stop you from using `sudo` at all. To troubleshoot this, follow the thread [HERE](https://askubuntu.com/questions/73864/how-to-modify-an-invalid-etc-sudoers-file)
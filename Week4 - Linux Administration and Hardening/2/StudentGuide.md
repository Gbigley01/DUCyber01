## 4.2 Student Guide: Linux Access Controls

### Class Overview

In today's class, we will continue our introduction to Linux by covering one of the operating system's most important functions: access control. You wll complete a sequence of tasks that will expose you to many of the most fundamental aspects of Linux security: password strength, careful control of the `sudo` command, and file permissions.

The skills and tools covered today will be essential for various professional roles, from systems administration to penetration testing.

### Class Objectives

By the end of class today, you will be able to:

- Audit passwords using `john`.

- Elevate privileges with `sudo` and `su`.

- Create and manage users and groups.

- Inspect and set file permissions for sensitive files on the system.

- Configure text files using `nano`


### Slideshow

The slides for today can be viewed on Google Drive here: [4.2 Slides](https://docs.google.com/presentation/d/1uqK4jfPMrZIaxAgBq1cVxJ8hxXhKAVmRp4wv3jr9F5U)

---

### 01. Welcome and Review

Welcome to the second class in on Linux. The topics of the previous class included:

- History and distributions of Linux.

- Navigating the Linux file structure using the command line.

- Managing processes with commands like `top`, `ps`, and `kill`.

- Installing packages using `apt`.
.

Today's class is focused on Linux's access control functions: passwords, file permissions, groups, and `sudo` access.

_Access control_ refers to regulating what actions users and programs are and are not allowed to take on a system.

Today will focus on users and the last day of the unit will focus on programs.

Today's class will expound on Day 1's topics by covering:

- Configuring text files with nano
- Password auditing.
- Switching between users with `su`.
- Elevating privileges with `sudo`.
- File permissions and access controls.
- Managing users and groups.



### 02. Write-Along with Nano

Being able to edit files on the command line is essential for any serious Linux users.

Thus far, we have investigated system files, stopped malicious processes, and installed a few tools to help us audit this system. Now, we will need to keep lists of things we find as well as edit system files and configuration files.

Because many Linux systems do not have a  GUI, editing system and configuration files on the command line is a common task and essential skill for administrators.


There are several text editors we can use to edit files, but in this class we will use the text editor Nano.

- Nano is included by default in almost all Linux distributions, so it's available on nearly every system you'll ever use.

- The other popular command-line text editors are emacs and vim. While extremely powerful, these editors have a steep learning curve, and are more appropriate for practicing professionals who work on headless systems often.

#### Nano Demonstration

In the upcoming demo, the senior administrator has asked that we set this system up with a message to display to all users who log in to the system. This will let them know that the system is "down for maintenance" and should not be used. This will allow us to conduct our audit without users making further changes.

To create this message, we need to use Nano to create and edit the `/etc/motd` file.

- `motd` stands for “message of the day," and it will display a message to any user who logs in successfully.

- We will also add a message to the `motd` file that warns users not to use or alter the system while it is down for maintenance.

Open a terminal.

- Run: `sudo nano /etc/motd`

This command opens a new file for editing. Ee can type in this file as if it were a normal text editor. We also have to use `sudo` because we are editing a file in the `/etc/` directory.

  - `sudo` will be covered in more detail later on. 

Note the following about navigation and commands:

- You can navigate between lines by using the arrow keys.

- The commands at the bottom of the window show how to save, exit, etc.

- The `^` character in the commands at the bottom of the window refer to the `CTRL` button

Type: `WARNING: System will go up and down for maintenance for the remainder of the day. Please avoid using this system if possible. If the system must be used, avoid any file modifications or configuration changes. Contact your system administrator with any questions you have about this downtime.`

- Type: `CTRL + x` to stop editing.

- Press `y` to save your file. This saves the new file to disk.

- Press `Enter` to exit Nano.

- Run `ls /etc`

A `motd` file has been created in `/etc`.

- Run `sudo cat /etc/motd` to show that it contains the message you typed earlier.

Open a new terminal. The message you entered in `/etc/motd` now appears as soon as you log in.

You can also use `nano` to read and edit files that already exist. This is no different from creating a new file. Simply type `nano path/to/file`, and continue editing.

- Run `sudo nano /etc/motd` again to open the file for reading.

- Run `CTRL+x` to close it again.

 ### 03. Users and Passwords

Your activities throughout the week involve auditing a malfunctioning server.

- In the previous class, we collected some important files, stopped a malicious process, and installed tools to facilitate the audit.

- Today, we will look at user access, starting with user passwords.

- In the previous class, we made a copy of `/etc/shadow`. This file contains every user's password on the system.

- The passwords are obscured with a hashing function, which means they are not stored in plain text.

#### A Brief Introduction to Hashes and Password Cracking

We have a whole unit later in the program dedicated to cryptography where will cover hashing in depth, but for now, here are a few basics:

- A hash is a cryptographic function that takes data as input and translates it to a string of different, random-looking data.

- A hash will always output the same string for the same input data. So, when a password is entered into the system, the system hashes it in the same way each time.

    - The same password will always produce the exact same hash.

- This hash is stored in the shadow file. When a user logs back in with the same password, the hash of the password they entered is compared with the hash stored for that user in the `/etc/shadow` file. If it matches, the user is logged in. If the hash doesn't match, the user is not logged in.

Note the following about password cracking tools:

- Password cracking tools do not reverse a password hash, but instead take a list of words and characters, and create a hash for each one.

- Each hash is then compared to the hash it is trying to crack, and if the two hashes match, the password has been found.

- This form of password cracking is known as a **brute force attack**.

- This is why the best passwords are long, with lots of random characters. The more random the password and the more characters it has, the longer it will take a cracking program to find a hash that matches it.

What makes a stronger password, it's complexity or it's length?

- Length and complexity work together to make a password strong.

- However, when it comes to brute force attacks, password length has more impact on the time it takes to crack it.

Whatis the current "industry standard" length that a password should be?

  - Currently, the industry standard for password length is eight characters.

  - We will soon find out that eight is only a minimum. It can still be cracked, though it takes some patience.

Navigate to [https://howsecureismypassword.net/](https://howsecureismypassword.net/).

To demonstrate the importance of length, we will repeat the same character in one long string.

- Enter `jjjjjjjj` (eight j's). Eight characters crack instantly.

- Enter `jjjjjjjjjjjj` (twelve j's). Twelve characters will take four weeks to crack.

- Enter `jjjjjjjjjjjjjjjj` (sixteen j's). This password takes 35 thousand years to crack.

- Enter `b4Ei@2!` (seven random characters). This password only takes seven minutes to crack.

- Enter `Jng0i$7w` (eight random characters). This password takes nine hours to crack.

- Enter `534Yc8@CmF` (ten random characters). This password takes 6 years to crack.

- Enter `*%uDiH2^T2n4` (twelve random characters). This password takes 34 thousand years to crack.

Takeaways of this section:

- If a system requires sixteen characters and nothing else, the password will remain relatively strong, even if words are embedded.

- Add in a few extra characters and it will get exponentially more secure.

- In contrast, if you use all random characters, you _still_ have to make the password at least 10 characters long for it to be very effective.

#### Managing Passwords as Administrators

As an administrator, we can do the following to control and secure user passwords:

- We may not be able to easily see what a user's password is, but we can see the last time they reset their password.

- We can cause the password to expire after some time so the user has to set a new password.

- We can also set length, number, and character requirements.


The only tools we need are `chage` (_change user password expiry information_) and `nano` to edit the settings inside the `/etc/security/pwquality.conf` file.

Note the following about `chage`:

- `chage` allows us to change the number of days between password changes for each user.

- The system uses this info to determine when a user must change their password.

- Below are some common options we can use with `chage`:

  - `chage -l` to show the account aging info.

  - `chage -M` to set the number of days between password expirations.

  - `chage -W` to set the number of warnings the user gets before the change must be made.

  - `chage -d 0` to force an immediate password change.

#### Administrating Passwords Demo

In the upcoming demo, we will update user Billy's password expiration information. We will also change the password strength requirements for the updated password. Specifically, we will:

- Change the maximum number of days between password changes to 90.

- Change the number of days of warning before a password expires to 10.

- Force Billy's current password to expire immediately.

- Ensure the new password differs from an old password by at least one character.

- Ensure the new password does not match common dictionary words.

- Set the minimum character length of new passwords to 12.

- Set the minimum character types in a password—such as uppercase letters, lowercase letters, numbers, and special characters—to two.


Let's begin by looking at Billy's password expiration info.

- Run `sudo chage -l billy`

- Our command output should be similar to the following:

  ```bash
  Last password change		                           : Dec 09, 2018
  Password expires		                           : never
  Password inactive		                           : never
  Account expires		                                   : never
  Minimum number of days between password change		   : 0
  Maximum number of days between password change		   : 99999
  Number of days of warning before password expires	   : 7
  ```

While the output is fairly self-explanatory, we will go over the main details:

- Billy’s password never expires and it has the highest value possible for the maximum number of days between password changes.

- Billy will get seven days of warning before his account forces a password change.

Now, we will change the number of days between expirations to 90 days.

- Run `sudo chage -M 90 billy`

  - Syntax breakdown:
    - `sudo` is used because this change has to be completed by an administrator.
    - `chage` is the change password expiry information command.
    - `-M` stands for _maximum_.
    - `90` is the maximum number of days we are setting.
    - `billy` is the user for which we want to make changes.


- Running `sudo chage -l billy` shows us that the maximum number of days between password change has been changed to `90` and the `Password expires` value has also been updated.

Now, we will set the `number of days of warning before password expires` to `10`.

- Run `sudo chage -W 10 billy`
  - Syntax breakdown:
    - `sudo` and `chage` stand for the same as the previous command.
    - `-W` stands for _warning_.
    - `10` is the number of days given to the warning setting.
    - `billy` is the user for which we want to make changes.

- Running `sudo chage -l billy` shows us that the `Number of days of warning before password expires` has been updated.

Next, we will force a password to expire immediately.

- Run `sudo chage -d 0 billy`

  - Syntax breakdown:
    - `-d` stands for _last day_. This sets the number of days since Jan 1st, 1970, when the password was last changed.
    - `0` is the number of days given to the last day setting. Essentially, this means, "This password has never been changed," which causes `chage` to require a password change.

To confirm our results:

 - Run `sudo chage -l billy`

 - The fields `Last password change`, `Password expires` and `Password inactive` have all been changed to `Password must be changed`.

 - Our output should look similar to this:

    ```bash
    Last password change		                         : password must be changed
    Password expires		                         : password must be changed
    Password inactive		                         : password must be changed
    Account expires		                                 : never
    Minimum number of days between password change		 : 0
    Maximum number of days between password change		 : 90
    Number of days of warning before password expires	 : 10
    ```

#### Updating Configuration Files

Now that we know how to force a password change, we can ensure that each user is required to create a strong password by editing the `/etc/security/pwquality.conf` file.

A brief review of Linux configuration files and the process of "commenting out":

- Configuration files will often have configurations written as comments.

- As you may know, comments in code begin with `#`. This symbol indicates to the system that these lines are not meant to be interpreted as a line of code, but rather intended to be read by the user as notes, tips, or additional information.

- Most configurations are written with a `#`, even though they are actually run-able processes. This way, admins can turn them on and off based on their preferences.

- To turn on these configurations, they simply delete the `#`. The system will then no longer read the line as a comment, but rather as the line of code that enables a configuration.

- The process of deleting the `#` and therefore enabling the configuration is called "commenting out."

For example: By default, this configuration will be commented out. It also includes an actual comment explaining what the configuration does.

  ```bash
  # Number of characters in the new password that must not be present in the old password
  # difok = 1
  ```

If the admin wants to enable and edit this configuration, they simply delete the `#` in front of the configuration:

  ```bash
  # Number of characters in the new password that must not be present in the old password
  difok = 1
  ```

#### Updating `etc/security/pwquality.config` File

We will now make changes to the `/etc/security/pwquality.conf` configuration file to ensure the following:

- In order to keep users from "changing" their old password to the exact same password, we will change the number of characters that must be changed during password updates, using the `difok` configuration.

- To keep users from using crack-able dictionary words in their passwords, we will enable the `dictcheck` parameter.

- We will also set the minimum password length to 12 characters and the minimum number of different character types—letters, numbers, special characters, etc—to two.

Note: We can set other configurations as well, but these are outside the scope of this demonstration.

- Run `sudo nano /etc/security/pwquality.conf`

The output should resemble the following:

  ```bash
  # Configuration for system wide password quality limits
  # Defaults
  #
  # Number of characters in the new password that must not be present in the old password
  # difok = 1
  #
  ```

For each setting in this file, there is a clear comment, starting with `#`, that describes what the proceeding setting does. In this file, we can see that the settings have been commented out.

Move to the `difok` setting and note the following:

- The comment describes the setting: `Number of characters in the new password that must not be present in the old password.`

- `difok` is set with a value of `1`, which means that the user only needs to change their password by one character to differentiate it from the old password.


We will uncomment this line and change its value to `2`.

- Make the update to the file as shown below:

  ```bash
  # Configuration for system wide password quality limits
  # Defaults
  #
  # Number of characters in the new password that must not be present in the old password
  difok = 2
  #
  ```

  - This configuration is now changed.

Next, scroll down to the `dictcheck` configuration:

- Configuration looks like:

  ```bash
  # Whether to check for the words from the cracklib dictionary.
  # The check is enabled if the value is not 0.
  # dictcheck = 1
  #
  ```

    - Again, a comment describes what the configuration does: `Whether to check for the words from the cracklib dictionary.`

    - There is also a line describing how to enable the configuration: `The check is enabled if the value is not 0.`

    - `dictcheck` has the current value of `1`, meaning it would be enabled if it were not commented out.

All we need to do is uncomment the `dictcheck` line to enable it.

- Make the update to the file as shown below:

  ```bash
  # Whether to check for the words from the cracklib dictionary.
  # The check is enabled if the value is not 0.
  dictcheck = 1
  #
  ```

Next, if we wanted to add minimum password length and character type requirements, we just add the following options to our file:

- `minlen = <minimum character length>`

- `minclass = <minimum number of character types>`

 Add the following lines to our file so that the minimum character length is 12, and the minimum number of character types is two.

- Run:

  `minlen = 12`  
  `minclass = 3`

Save the file. The next time someone changes their password, these new settings will be used for password requirements.

#### Summary

In this demonstration, we:

- Updated Billy's password expiration info, so that the maximum time between password updates is 90 days. Billy will now also get 10 days of warning before he has to update his password.

- Changed `difok` to require users to make a unique password.

- Enabled `dictcheck` to automatically check whether passwords use dictionary words.

- Set the minimum character length to 12 and the minimum number of character types to two.

We covered the following four commands:

- `chage -l` to show the account aging info.

- `chage -M` to set the number of days between password expirations.

- `chage -W` to set the number of warnings the user gets before the change must be made.

- `chage -d 0` to force an immediate password change.

This password strength file is located in `/etc/security/pwquality.conf`.


### 04: Activity: Let's Talk to John

- [Activity File: Let's Talk to John](Activities/03_STU_Talk_to_John/Unsolved/README.md)



### 05: Activity Review: Let's Talk to John

- [Solution Guide: Let's Talk to John](Activities/03_STU_Talk_to_John/Solved/README.md)

### 06: Privileges, `root`, `sudo` and `su` Demo

We've been using `sudo` for several commands over the last two days of class.

Why is `sudo` is needed for some commands and not others? Note the following about permissions: 

- Every file and program on a Linux system has permissions associated with it. These permissions tell the system what user can access that file or run that program.

- Additionally, administrators can place users in a group, and set file and program permissions to allow a specific group or groups to have access.

- For instance, a company can create a group for employees who work in Marketing and another group for employees who work in Accounting. The administrator can give these groups access to specific programs needed by their department. 

- The permissions for a given file or program apply to all the users on the system, except for the root user.

- The root user is the super user, or the highest administrator on the system. The root user has complete access to the system and can perform any action, access any file, and run any program.

During the last activity, we learned just how sensitive the `/etc/shadow` file is. Typically, **only** the root user has access to this file. This is an example of how permissions can protect parts of the system.

When an attacker is trying to gain access to a system, they are usually trying to gain `root access` or access to the root user, so they can do whatever they want to the system. Hackers can achieve this access by switching users.


#### Switching Users and Elevating Privileges

The Linux system can access different users with `su`.

- `su` stands for _switch user_. If you have another user's password, you can log in as that user with `su <username>`.

- Switching users can be helpful for troubleshooting. You can see firsthand what the user has access to, and test their permissions. You can also see what they've been doing with the system from their perspective, with full access to their files.

- From a security perspective, switching users allows you to use the system with their permissions. This lets you run commands as that user, view files that only that user has access to, and otherwise imitate the user.

Linux systems secure root access with `sudo`.

- Properly secured Linux systems do not allow anyone to log in as the root user on the system. Instead, following the principle of least privilege, if a user needs access to something only the root user can do, they can use the `sudo` command to invoke the root user just for that one command.

- `sudo` stands for _superuser do_, and if a normal user is allowed to use `sudo`, they can run a root-privileged command. When the command is complete, the user is reverted to their normal access.

- `sudo` can also control which commands the user can run as root user. This way, the system has granular control over who can run root commands, and which ones. It also keeps a log of exactly which user runs which commands, which can be reviewed as needed.

To configure `sudo` access:

- `sudo` access is configured using a configuration file—the `sudoers` file.

- Inside that file, a `sudo` group is specified along with which commands `sudo` can be used with.

- The `sudo` group is typically given full system access to use `sudo`.

- Any user on the system that needs `sudo` access is then added as a member of the group. Any member of the group receives the same access and ability to use `sudo` for any command.

- Alternatively, a user can be kept out of the `sudo` group and added to the configuration file individually, along with a specification of which commands that user can use `sudo` for.

- Adding a user individually to the `sudo` configuration file is common when the sysadmin has a user that only needs `sudo` access for a few commands.

#### `su` vs. `sudo` Demonstration

In the next demo, we will attempt to update all of our existing software packages.
- If our privileges do not allow us to do so, we will first use `su` to switch directly to the root user.

- We'll then show the dangers of working directly as the root user.
- We'll then do the same updates by using `sudo` instead and show why this is the more secure option.

We will use the following commands to do these tasks:
  - `whoami` to view your current user.
  - `su` to switch to another user, in this case, the root user.
  - `sudo` to invoke the root user for one command only.

Pull up a terminal in the instructor Ubuntu VM:
  - Username: `instructor`
  - Password: `instructor`

Running `whoami` shows that we are the `instructor` user.

- Run `apt update` to see the following:

  ```bash
  # apt update
  Reading package lists... Done
  E: Could not open lock file /var/lib/apt/lists/lock - open (13: Permission denied)
  E: Unable to lock directory /var/lib/apt/lists/
  ```

When we run `apt update` in the terminal, this doesn't work.

- Only the  `root` user has the ability to use the `apt` program. Because we are not `root`, we received a `Permissions denied` error.

- The `Permission denied` message indicates that you do not have permission to open a file (`/var/lib/apt/lists/lock`), and that you need to run `apt` with elevated privileges.

We will now log in as the root user with `su`, which again, stands for _switch user_.

- Run `sudo su` (password: `instructor`)

- Run `whoami` to show that we are now `root`.

- The prompt now also uses a `#`, indicating that we are the root user. A standard user's prompt will generally show a `$`.

Now that we’re the root user, we can install packages.

- Run `apt update` as `root` and we should see the following:

  ```bash
  Hit:1 http://us.archive.ubuntu.com/ubuntu bionic InRelease
  Get:2 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]                     
  Get:3 https://download.docker.com/linux/ubuntu bionic InRelease [64.4 kB]                       
  Get:4 http://us.archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB] 
  ```

- This command updates the package repositories so we can download the latest software.

Once you, or a process, is logged in as `root`, you can make any changes you want to the system, including changes or malicious actions that may harm the system.

Here is a quick example:

- Make sure you're (still) `root` with `sudo su` (password `instructor`) and do the following:

  - Run `ls /home` to show the current home folders.

  - Run `rm -r /home/john` to remove the home folder for `john`.

  - Run `ls home` again to show that it is removed.

  - Run `mkdir /home/john` to create a new empty `home` directory for `john`.

  - Lastly, run `chown -R john: /home/john` to give the user, `john`, ownership of their newly created home directory.

At no time during this process were we asked for a password.
- That is because we are the root user and can perform any action we wish, without the system stopping us.

- Not only is this a problem if we want to make system and software changes, but it's also a problem if we were to make a mistake and remove the wrong files.

Once we are logged in as another user, we can log out by typing `exit`.

- Run `exit`  and this will log us out from the `root` user.

A better alternative to making the same changes is to use `sudo`.

- `sudo` will always ask you for a password, and it will only allow you to complete the actions you have access to.

- `sudo` adds a layer of security because it forces the administrator to consciously run a command with privileges.

- `sudo` also saves a log for each time the command is used. Therefore, an administrator can audit the log to find out which user did what.

Run `sudo apt update` and note that we have to first enter our password to use `sudo`.

Now we will try to delete a directory like we did previously:

- Run `ls /home` to show the current home folders.

- Run `rm -r /home/john`

Our output should be similar to:

```bash
$ rm -r /home/john
rm: cannot rm directory ‘/home/john’: Permission denied
```

Restricting `sudo` use among users and only allowing access for specific commands reduces the risk of harm to the system.



#### Assigning `sudo` Access Demo

Note that in the previous demo, we didn't have to log in as `root` because we could just use the `sudo` command to use the `apt` command.

If we want to see exactly what `sudo` access we have, we can run `sudo -l`.

- Run `sudo -l`. Our output should contain the line:

```bash
  User instructor may run the following commands on localhost:
      (ALL) ALL: ALL
```

- We, the instructor user, have `ALL` access.

We can check the privileges of a user with the `-lU` options. We can check the privileges of a user, `sally`, with the following command.

- Run `sudo -lU sally`. Our output should be:

```bash
User sally is not allowed to run sudo on ubuntu-vm.
```

We can give `sally` full `sudo` access by adding her to the `sudo` group.

- Run `sudo usermod -aG sudo sally` to add Sally to the `sudo` group.


- Run `sudo -lU sally`. Our output should now read:

```bash
  User user may run the following commands on localhost:
      (ALL) ALL: ALL
```
- `sally` now has full access.

We can also give a user `sudo` access for just a single update. For example, we want to give our user `john`  `sudo` access for `apt` so he can run software updates.

Why can't we just add `john` to the `sudo` group?
- This will give him full access to run any command, which we don't want.


Remember, the `sudo` settings are configured in the `/etc/sudoers` file.

In order to update the `/etc/sudoers` file, you must use the command `visudo`, which opens the `etc/sudoers` file using Nano.
  - Using `visudo` to edit this file is necessary because `visudo` does a syntax check on the `sudoers` file before it is saved, to prevent corruption of the file.

  - Breaking this file can lock you out of the system entirely, so you want to be sure to always use `visudo` to edit the file.

Run `sudo visudo`

Scroll down to find the following lines at the bottom of the file:

  ```bash
  # User privilege specification
  root  ALL=(ALL:ALL) ALL

  # Members of the admin group may gain root privileges
  %admin  ALL=(ALL) ALL

  # Allow members of group sudo to execute any command
  %sudo  ALL=(ALL:ALL) ALL
  ```

Note the following:

- `root  ALL=(ALL:ALL) ALL`: Allow the `root` user to run any command under any user or group on any system.

- `%admin  ALL=(ALL) ALL`: Allow all members of the `admin` group to run any command with `sudo` under any user on any system.

- `%sudo  ALL=(ALL) ALL`: Allow all members of the `sudo` group to run any command with `sudo` under any user on any system.

The general syntax of these lines are as follows:

- [`USER` or %`GROUP`]  `HOST`=(`USER`:`GROUP`) `COMMAND`

  - The `HOST` is normally set to `ALL` but can be changed if the administrator wants to limit which machines can use this file.
- For a group entry, the `GROUP` inside the parenthesis can be left out: %`GROUP` `HOST`=(`USER`) `COMMAND`
- To remove the password requirement, `NOPASSWD` is added: `USER` `HOST`=(`USER`) `NOPASSWD`: `COMMAND`

This means any user in the secondary group `sudo` _or_ `admin` can use `sudo` to run privileged commands with their password.

Add the line `john  ALL=(ALL:ALL) /usr/bin/apt-get`.

- Syntax breakdown:

  - This allows the user `john` to run the `apt` command with `sudo` as the `root` user,  on any `host`, after entering his password.

  - `john` now has access to run the `apt` command and update software packages.

Save and exit.

Verify your new settings.

- Run `sudo -lU john`

- Output should look like:

    ```bash
     User john may run the following commands on localhost:
      ALL=(ALL:ALL) /usr/bin/apt-get
    ```

#### Attackers Gaining Root Access Demo

Even when `sudo` use is restricted to specific commands, depending on the command, a user can still gain access to `root`.

In this last demo, we will pretend we are an attacker and attempt to gain `root` access from an account that has `sudo` access to one of these commands.

There are several different commands for which this can be a problem, but today we will look at the `less` command.

Let's return to our example of `john`. In addition to allowing `john` the ability to install software, we may also want to allow him to read any of the sensitive files on the system using `less`.

- `less`, however, has a feature that allows you to run commands without exiting the `less` command, and those commands are run with the same privileges that `less` has.

  - In other words, if a user has `sudo` access for `less`, they can open `less` and then start running commands from inside `less` with `sudo` privileges.

To demonstrate this, we will use `sudo less` with the admin user and then move from `less` directly into a root shell with `!bash`.

- Run `sudo visudo` and edit the entry for `john` to give him `sudo` access to `less`.

- Output should look like:
```
    john ALL=(ALL:ALL) /usr/bin/apt-get, /usr/bin/less
```
Save and exit.

Now we will run `sudo less` on any file that belongs to John:

- Run `su john` (password: `lakers`) to switch to John's user.

- Run `touch /home/john/my_file`

- Run `sudo less /home/john/my_file`

Because we ran `less` with the `sudo` command, when we are inside `less` we are no longer `john`. Instead, we are now `root`.

To run a command from inside `less`, we use `!` followed by the command.

You can run any command with `less`, but it makes the most sense to run `bash`. This command will launch another shell from inside `less` with your current `root` privileges.

- Type `!bash` and press `Enter` to drop into a root shell.

We now have a `#` at the prompt again, indicating we have `root` privileges.

- Run `whoami` to confirm that we are `root`.

Attackers often look for this kind of loophole to escalate their privileges on a system.

- This kind of exploit is called an **escape** exploit because you are _escaping_ the program `less` and getting full system access.

- It's important to restrict which commands users can use with `sudo` in `/etc/sudoers` and to always make sure there are no known vulnerabilities with the commands you _do_ allow.

#### Summary

We used the following commands in the demo:

- `whoami` to determine your current user.

- `su` to switch to another user, in this case the root user.

- `sudo` to invoke the root user for one command only.

- `sudo -l` to list the `sudo` privileges for a user.

- `visudo` to edit the `sudoers` file.


### 07: Activity: `Sudo` Wrestling

- [Activity File: `Sudo` Wrestling](Activities/06_STU_Sudo_Wrestling/Unsolved/README.md)


### 08. Activity Review: `Sudo` Wrestling

- [Solution Guide: `Sudo` Wrestling](Activities/06_STU_Sudo_Wrestling/Solved/README.md)

#### Activity Recap

- You must first look at your own user privileges before looking at the rest of the users.

- `sudo -l` is a great command to remember and is often useful in figuring out what you can do on a system.

- As with `less`, there are exploits for `vim`, `more`, `python`, `ruby` and `perl`, should a user have permission to run one of these with `sudo`.

- This exercise clarifies just one reason why securing `sudo` and `root` access is important. Being able to determine which users or processes have root access is a core skill of a system administrator.

- Admins will often ensure that users are not set up with any additional access to `sudo` or `root` than is necessary, following the principle of least privilege.

### 09. Break

### 10. Users and Groups

To recap:

- Linux is a multi-user OS and related users can be added to groups.

- We briefly discussed this when we spoke about the `sudo` and `admin` groups.

- In the case of `sudo`, all users added to the `sudo` or `admin` groups have full access to `sudo`.

Linux has the ability to create groups of users for other functions, like file or services sharing:

- If a company has different departments like Sales, Accounting, and Marketing, a Linux administrator can create a group for each department. Only the users in the group can access files owned by the group.

- Therefore, a system admin must know how to to add and remove users from a system, add and remove groups, and add and remove users from those groups.

Linux has a few easy commands that are used specifically for user and group management, which we will focus on in this section.

Before diving into these commands, we’ll cover how Linux identifies users and groups in the system using the `id` command. 

Note the following about the `id` command:

- Linux associates a specific number with each user for identification purposes. This number called a **user ID**, or **UID**.

- When Linux needs to identify a user, it doesn’t look at the username, it uses the UID number.

- System users, or automated users designed to complete system tasks, have UIDs assigned at numbers less than `1000`.

- Standard users, or users that are assigned to a real person, have UIDs assigned at numbers greater than `1000`.

- The root user always has the UID of `0`.

- Likewise, the **GID** is the **group ID** that is associated with a group.

Run `id`.

- Our UID is above `1000`, which indicates that we are a standard user.

We can also see the UID for each user in the `/etc/passwd file`.

- Run  `head /etc/passwd`

  - The system UIDs start with root at `0` and move up from there.

Remember, UIDs and GIDs are only a system number that Linux uses for identification.

If we want to see the groups that a user belongs to, we can use the command `groups`.

- Run `groups`

  - It prints our user's groups to the screen.

- Run `id`.

  - That this also shows us the groups along with the GID's assigned to them.

#### Users and Groups Demo

**Note:** Before beginning this demo please run the following command:
- `sudo adduser mike`
- `sudo addgroup general`
- `sudo usermod -aG general mike`


In the upcoming demo, we’ll dive into more actions around user and group management, using the following scenario:

- The company you work for recently had a change to its developer team. Mike, a lead developer, has left the company. Joseph has joined as a new junior developer.

- The company's Linux system has never been set up properly with a `developers` group. Instead, Mike was part of the `general` group.

- As the sysadmin for this system, you need to remove Mike from the `general` group, remove the `general` group, and delete Mike's user from the system. Then, you need to add Joseph to the system, create a `developers` group, and add Joseph to this group.

In order to accomplish these tasks, we will:

1. Get group info for Mike's user using the command `groups`.

2. Lock Mike's account to prevent him from logging in using the command `usermod`.

3. Remove the `mike` user from the `general` group with the command `usermod`.

4. Delete the `mike` user by using the command `deluser --remove-home`.

5. Delete the `general` group using the command `delgroup`.

6. Create a `joseph` user with the command `adduser`.

7. Create a `developer` group using the command `addgroup`.

8. Add the `joseph` user to the `developer` group using the command `usermod`.


First, we'll see what groups Mike belongs to.

- Run `groups mike` to print `mike`'s groups to the screen.

- Our output should be:

  ```bash
  $ groups mike
  mike general
  ```
- Each user is also a member of a group that shares the name of the user.

  - When a user is created, Linux by default creates a group for which that user becomes a member.


The `usermod` command has many different options and lets us do many things to user accounts, but we are going to look at the `-L` and `-G` options. The `L` option will lock the account and the `-G` option will specify the groups a user should belong to.

- Run `sudo usermod -L mike` to lock the account.

  - Syntax breakdown:

    - `sudo`: Only `root` can modify users and groups, so we will have to use `sudo` for all of our commands.
    - `usermod`: Allows us to make many modifications to users. In this case, we are using it to add and remove groups.
    - `-L`: `usermod` flag that locks an account so it cannot be logged into.
    - `mike`: The `usermod` command always ends with the user we are modifying.


- Run `sudo usermod -G mike mike` to remove `mike` from the `general` group.

  - Syntax breakdown:

    - `sudo`: Only `root` can modify users and groups, so we will have to use `sudo` for all of our commands.
    - `usermod`: Allows us to make many modifications to users. In this case, we are using it to add and remove groups.
    - `-G`: This `usermod` flag specifies which groups the user should belong to. The groups  we specify following this command will be the _only_ groups that user belongs to after we run the command.
    - `mike`: Following the `-G` flag are the groups we wish the user to belong to. In this case, we want the user `mike` to be a member of the `mike` group only, effectively removing the `general` group.
    - `mike`: The `usermod` command always ends with the user you are modifying.

- Run `groups mike` to confirm the result.

  - Our output should be:

    ```bash
    $ groups mike
    mike
    ```

  - Mike has successfully been removed from the `general` group.

We can now remove the `mike` user from the system using the `deluser` command.

- Run `sudo deluser --remove-home mike` and break down the syntax:

  - `sudo`: Only `root` can modify users and groups, so we will have to use `sudo` for all of our commands.
  - `deluser`: Allows us to delete users from the system.
  - `--remove-home`: `deluser` flag that removes the user's home folder along with the user.
  - `mike`: The `deluser` command always ends with the user we wish to delete.

If we use the `deluser` command without any flags, it will leave all of Mike's files intact including his home folder. In this case, we will remove the user _and_ remove all his home folder files.

- Run `ls /home` to confirm our results.

  - Mike's home folder has been deleted.

Remember how we can verify users or groups on the system:

- We can check for users in the `/etc/passwd` file with `less /etc/passwd`.

- We can check for groups in the `/etc/group` file with `less /etc/group`.

  - Run `less /etc/passwd` to verify that `mike` is deleted.

  - Run `less /etc/group`

  - The `general` group still exists. The line for the `general` group should look like this:

    ```bash
    general:x:32:
    ```

  - If this group had any members, they would be listed after the last `:`. In this case, there are no members left in this group.

We can now remove the `general` group with the `delgroup`.

- Run `sudo delgroup general`

  - Run `less /etc/group` to verify it is gone.

Now, we will create our new user, `joseph`.

- Run `sudo adduser joseph` and complete the prompts to give `joseph` a password and other info.

- Run `groups joseph` to display the `joseph` group.

   Our output should look like:

  ```bash
  $ groups joseph
  joseph
  ```

Remember, when a user is added to the system, by default, a group by the same name is added. Also, when a user is deleted, their group is also deleted, as long as no other users are members of that group.

Next, we will create a new `developer` group using the `addgroup` command. Then, we can add the user `joseph` to the group.

- Run `sudo addgroup developers`

We received a `Done` message, but we can also verify this group was added in the `/etc/group` file.

- Run `tail /etc/group`

  - We can now see both the new `joseph` group that was created when we added the user `joseph`, as well as the new `developers` group that we just created.

We are now ready to add `joseph` to the `developers` group using the `usermod` command.


- Run `sudo usermod -aG developers joseph`

  - Syntax breakdown:

    - `sudo`: Only `root` can modify users and groups, so we will have to use `sudo` for all of our commands.
    - `usermod`: Allows us to make many modifications to users. In this case, we are using it to add and remove groups.
    - `-aG`: This `usermod` flag combination (_add group_) specifies what groups the user should be added to.
    - `developers`: Following the `-aG` flag are the groups we wish to add the user to. In this case, we want the user `joseph` to the `developers` group.
    - `joseph`: The `usermod` command always ends with the user we are modifying.


- Run `groups joseph`

  - Joseph is now part of the `developer` group, as a secondary group.

- Our output should be:

  ```bash
  $ groups joseph
  joseph developers
  ```
- We have now created the `joseph` user, created the `developers` group and added `joseph` to it.

A user always has a _primary_ group that is typically the same name as the user. The primary group can be changed to another group, but there isn't usually a reason to do so.

Groups that a user is added to beyond the primary group are known as _secondary_ groups. A user can be a member of unlimited secondary groups.

In this demo, we:

1. Received group info for the `mike` user with the command `groups`.

2. Used `usermod` to lock `mike`'s account to prevent him from logging into our system.

3. Removed the `mike` user from the `general` group using the command `usermod`.

4. Deleted the `mike` user with the command `deluser --remove-home`.

5. Deleted the `general` group with the command `delgroup`.

6. Created a `joseph` user with the command `adduser`.

7. Created a `developer` group with the command `addgroup`.

8. Added the `joseph` user to the `developer` group using the command `usermod`.


### 11. Activity: Users and Groups  

- [Activity File: Users and Groups](Activities/10_STU_Users_and_Groups/Unsolved/README.md)

### 12. Activity Review: Users and Groups

- [Solution Guide: Users and Groups](Activities/10_STU_Users_and_Groups/Solved/README.md)

---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

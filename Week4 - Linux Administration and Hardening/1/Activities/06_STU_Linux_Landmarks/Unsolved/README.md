## Activity File: Linux Landmarks

For the activities over the next few days, you will be acting as a **Junior Linux Systems Administrator** at _Corp X_. A senior administrator has asked you to to audit a malfunctioning Linux server. As such, all of the activities over the next week will take place in the same lab environment.

You will complete several tasks in the next week of class activities and homeworks related to **Linux auditing and hardening**. Everything you do will be second nature for many Linux administrators, and are great skills to talk about during job interviews.

The first step for troubleshooting any computer issue is gathering information. In this activity, the senior administrator has sent you a list of information to gather about the target system. You will use this information for further analysis.

You will start with a basic audit of system files, exploring some of the most important locations in the file system to identify evidence of suspicious activity. To keep yourself organized, you'll also create a directory to store what you find.

Use the following credentials to log into the lab environment:

- **Username**: `sysadmin`
- **Password**: `cybersecurity`

Be sure to ask your instructors and classmates for help if you get stuck.

To setup this activity, students will need to run this command: `sudo bash /home/instructor/Documents/setup_scripts/instructor/landmarks_review.sh`
    
- Ignore any `rm: cannot remove` errors you see.

### Instructions:

Here is the Audit Checklist provided by your Senior Administrator. Refer to the detailed instructions below if you need help with a specific step.

1. Create a new directory in your home folder, called `research`. You'll save all your results here.

2. Copy all system logs to your research directory. These will be used to determine if any running services have recently reported errors.

3. Check the users' personal directories for suspicious files. Move your findings to your research folder. The forensics team will analyze what you find.

4. Create a list of all currently installed binaries. Make sure your list includes both user and system binaries. You'll check this list for suspicious software.

5. Check for suspicious files in temporary directories. Move anything you find to your research folder.

6. Create a list of all users and their password hashes.

7. Check that the only users with accounts in the `/home` directory are `adam`, `billy`, `instructor`, `jane`, `john` `max`, `sally`, `student`, `sysadmin` and `vagrant`. There should not be additional directories. Copy anything abnormal to your research directory.

Try to complete the steps above without using the hints below. If you get stuck, refer to the tips below.

---
#### Further Instructions  

In your home directory, create a folder called `research` where you will store all of your findings.

Copy all of the log files from the _standard Linux log directory_ into your research directory.

Move to the `root` directory, and list all the files. Compare the list to the default contents listed below. Save anything unusual to your research directory.

```
# Default contents of Root Directory
/bin
/boot
/dev
/etc
/home
/lib
/media
/mnt
/opt
/proc
/root
/run
/sbin
/srv
/sys
/tmp
/usr
/var
```

Move to the directory that holds host-specific, system-wide configuration files, and list its contents.

- Read the file that holds a list of all the users on the system.

- Read the file that holds a list of all the password hashes for each user on the system.

- Read the file that contains a list of IP addresses and their corresponding host names.

- Copy these three files into your research directory for later review.


Move to the directory that holds essential binary files, and list the files it contains. Recall that there are multiple such directories.

- Look closely at the contents of this directory—specifically, pay attention to the files beginning with the letters `l`, `c`, and `t`. Do you notice anything familiar?

- Save a list of the programs in these directory to your research folder for later review.

Move to the directory that holds files that are expected to change on a regular basis. List the directories it contains.

- What directory keeps temporary files that are preserved between reboots?

- What directory keeps log files?

- What directory keeps mail data?

- See anything suspicious in these folders?

- Copy any suspicious files to your research directory.

Move to the directory that stores user home folders and list its contents. 
- Check that the only users with accounts in the `/home` directory are `sysadmin`, `adam`, `billy`, `sally` and `max`. There should be no additional directories. 
- Copy anything out of the ordinary to your research directory. Save a list of the home folders to your research directory.

Finally, move to the directory that holds temporary files that are deleted on reboot. Copy any suspicious files to your research directory.

-------

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.


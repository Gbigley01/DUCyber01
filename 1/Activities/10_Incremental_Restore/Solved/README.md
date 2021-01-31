## Solution Guide: Restoring Data with Incremental Backups

The goal of this activity was to test a backup to ensure that a system can be restored in the event of an attack.

### Questions

1. What is the difference between a `full` and `incremental` backup?

    - A **full backup** saves every file on a hard drive. 
    - An **incremental backup** saves only the data that has changed since the last full backup.

2. If you have a backup schedule of Monday, Tuesday, Wednesday, Thursday and Friday:  

    - On what day would you schedule a level 0 backup to be done?

        - Monday

    - In what order should the backups be applied to restore a system that was completely lost after an attack?

        - Start with Monday, end with Friday. 

3. What command **would** you use to create a level 0 backup of `archive/home/user1`? 
    
    - `tar cvvWf backup.tar --listed-incremental=backup.snar --level 0 archive/home/user1`

4. What command **would** you use to list the contents of an incremental backup?

    - `tar tvvf backup.tar --incremental`

5. After listing the contents of an incremental backup, what do the following letters indicate:

    - **`Y`** indicates that the file is contained in the `backup.tar` archive.

    - **`N`** indicates that the file was present in the directory at the time the archive was made, but was not added to the `backup.tar` archive because it has not changed since the last backup.

    - **`D`** indicates the file is a directory.

### Incremental Backup Restoration

1. Move into the `~/Documents/epscript/testenvir` directory and list the contents. Note the contents and then move back up to the `epscript` directory.

    - Run `cd ~/Documents/epscript/testenvir`

    - Run `ls -l`

        - We can see the `doctor`, `patient`, and `treatment` directories.

    - Run `cd ..`

2. In your `~/Documents/epscript` directory, create the level 0 backup of the `testenvir` directory, which contains the `doctor`, `patient`, and `treatment` directories.

- Create the level 0 backup of the `testenvir` directory by running:
   
  - Run `tar cvvWf epscript_back_sun.tar --listed-incremental=epscript_backup.snar --level=0 testenvir`

    Your output should look similar to this:

    ```
    tar: testenvir: Directory is new
    tar: testenvir/doctor: Directory is new
    tar: testenvir/patient: Directory is new
    tar: testenvir/treatment: Directory is new
    drwxr-xr-x sysadmin/sysadmin    0   2019-07-18  09:10   testenvir/
    drwxr-xr-x sysadmin/sysadmin    0   2019-07-16  15:07   testenvir/doctor
    drwxr-xr-x sysadmin/sysadmin    0   2019-07-16  15:26   testenvir/patient
    drwxr-xr-x sysadmin/sysadmin    0   2019-07-16  15:24   testenvir/treatment
    ...
    ...
    ```

3. Use the `tar` command to list the contents of the level 0 backup:

  - Run `tar tvvf epscript_back_sun.tar --incremental`

  - Status of the files in the backup should look similar to:

    ```
    drwxr-xr-x sysadmin/sysadmin    29   2019-07-18  09:10   testenvir/
    D doctor
    D patient
    D treatment

    drwxr-xr-x sysadmin/sysadmin    171   2019-07-16  15:07   testenvir/doctor/
    Y doctors.1.csv
    Y doctors.10.csv
    Y doctors.11.csv
    ...
    ...

    drwxr-xr-x sysadmin/sysadmin    166   2019-07-16  15:26   testenvir/patient/
    Y patients.csv
    Y patients1.csv
    Y patients10.csv
    ...
    ...

    drwxr-xr-x sysadmin/sysadmin    188   2019-07-16  15:24   testenvir/treatment/
    Y treatments.csv
    Y treatments1.csv
    Y treatments10.csv
    Y treatments2.csv
    ...
    ...
    ```

- What is the status of the files in the backup?

    * **`D`** indicates directories.

    * **`Y`** indicates that these file are contained in the `epscript_back_sun.tar` archive.

4. Next, let's extract the missing patient files from the `epscript_back_sun.tar` file, save them to a new directory `~/Documents/epscript/restore`, then restore them to the `~/Documents/epscript/testenvir/patient/` directory.

- First, let's create the new directory:

   - From inside the `~/Documents/epscript` directory:
     
       - Run `sudo mkdir restore`

   - Then extract the **patient's files** to the newly created directory `~/Documents/epscript/restore`:
   
     - Run `sudo tar xvvf 20190814epscript.tar -R -C restore/ epscript/patients/`

- Now that we've staged our missing files for restoration, let's move them into the appropriate directory:

   - Run: `sudo cp -r restore/epscript/patients/* testenvir/patient`

- Verify that the files have been added to the `testenvir/patient` directory successfully.

    - Run `ls -l testenvir/patient`

    Your output should look similar to the following:

    ```
    total 324
    -rw-r--r-- 1 sysadmin sysadmin   6299 Apr 28 00:25 patients.1.csv
    -rw-r--r-- 1 sysadmin sysadmin   6299 Apr 28 00:25 patients.2.csv
    -rw-r--r-- 1 sysadmin sysadmin   6299 Apr 28 00:25 patients.3.csv
    -rw-r--r-- 1 sysadmin sysadmin   6299 Apr 28 00:25 patients.4.csv
    -rw-r--r-- 1 sysadmin sysadmin   6299 Apr 28 00:25 patients.5.csv
    ```
    - **NOTE** That the missing files located in the `patient` directory in the archive have been properly restored.

- **NOTE** We could repeat this for the other missing directories `doctors` and `treatment` as follows:

   -  Extract the **Doctor's** files:
   
      - Run `sudo tar xvvf 20190814epscript.tar -R -C restore/ epscript/doctors/`

    -  Extract the **Treatment's** files:
   
       - Run `sudo tar xvvf 20190814epscript.tar -R -C restore/ epscript/treatments/`

5. To create an incremental backup that will include the added files:

    - First, ensure your in the epscript directory.

      - Run `cd epscript`

    - Then run `tar cvvWf epscript_back_mon.tar --listed-incremental=epscript_backup.snar testenvir` 

6. List the contents of the `epscript_back_mon.tar` incremental backup.

    - Run `tar tvvf epscript_back_mon.tar --incremental`

      - Your output should look similar to:

      ```
      drwxr-xr-x sysadmin/sysadmin    29   2019-07-18  09:10   testenvir/
      D doctor
      D patient
      D treatment

      drwxr-xr-x sysadmin/sysadmin    171   2019-07-16  15:07   testenvir/doctor/
      N doctor_tar.tar
      N doctors.csv
      N doctors1.csv
      ...
      ...

      drwxr-xr-x sysadmin/sysadmin    166   2019-07-16  15:26   testenvir/patient/
      N patients.csv
      N patients1.csv
      N patients10.csv
      Y patients11.csv
      Y patients12.csv
      Y patients13.csv
      N patients2.csv
      ...
      ...

      drwxr-xr-x sysadmin/sysadmin    188   2019-07-16  15:24   testenvir/treatment/
      N treatments.csv
      N treatments1.csv
      N treatments10.csv
      ...
      ...
      ```

- What is the status of the files in the incremental backup?

    - **`D`** indicates directories.

    - **`N`** indicates that the file was present in the directory at the time the archive was made, but was not added to the `epscript_back_mon.tar` archive because it had not changed since the last backup. 

    - **`Y`** indicates that the file is contained in the `epscript_back_mon.tar` archive.

7. Remove the following files from the `~/Documents/epscript/testenvir/patient` directory by running:

    - `cd ~/Documents/epscript/testenvir/patient`

    - `rm patients.{21..25}.csv`

8. The `epscript_back_mon.tar` incremental backup is the only backup that is required to replace the **deleted** files.  
    
    - The `epscript_back_sun.tar` level 0 backup is needed if a **full system restoration** is required.  It would then be followed by the `epscript_back_mon.tar` incremental backup. 

9. To restore the deleted files, in the `~/Documents/epscript` directory, run:

    - `cd ~/Documents/epscript` 

    - `tar xvvf epscript_back_mon.tar -R --incremental`

      - The snapshot file is not included in the command because the incremental file contains all the information to implement the restoration.

      Your output should look similar to:

      ```
      block 1: drwxr-xr-x sysadmin/sysadmin   29  2019-07-18  09:10 testenvir/
      block 3: drwxr-xr-x sysadmin/sysadmin   171  2019-07-16  09:10 testenvir/doctor
      block 5: drwxr-xr-x sysadmin/sysadmin   214  2019-07-18  11:38 testenvir/patient
      block 7: drwxr-xr-x sysadmin/sysadmin   188  2019-07-15  15:24 testenvir/treatment
      block 9: -rw-r--r-- sysadmin/sysadmin   123847  2019-07-18  11:38 testenvir/patient/patients11.csv
      block 252: -rw-r--r-- sysadmin/sysadmin   123847  2019-07-18  11:38 testenvir/patient/patients12.csv
      block 495: -rw-r--r-- sysadmin/sysadmin   123847  2019-07-18  11:38 testenvir/patient/patients13.csv
      block 737: ** Block of NULS **
      ```

    - List the contents of the `patient` directory after restoration with:

    - `ls -lat testenvir/patient` to show the restored files:

      ```
      total 308
      drwxr-xr-x 2 sysadmin sysadmin   4096 Apr 28 00:25 .
      -rw-r--r-- 1 sysadmin sysadmin   6299 Apr 28 00:25 patients.21.csv
      -rw-r--r-- 1 sysadmin sysadmin   6299 Apr 28 00:25 patients.22.csv
      -rw-r--r-- 1 sysadmin sysadmin   6299 Apr 28 00:25 patients.23.csv
      -rw-r--r-- 1 sysadmin sysadmin   6299 Apr 28 00:25 patients.24.csv
      -rw-r--r-- 1 sysadmin sysadmin   6299 Apr 28 00:25 patients.25.csv
      drwxr-xr-x 5 sysadmin sysadmin   4096 Apr 27 23:34 ..
      -rw-r--r-- 1 sysadmin sysadmin   6520 Apr 27 10:56 patients.4.csv
      -rw-r--r-- 1 sysadmin sysadmin   6361 Apr 27 10:56 patients.16.csv
      -rw-r--r-- 1 sysadmin sysadmin   6211 Apr 27 10:56 patients.3.csv
      -rw-r--r-- 1 sysadmin sysadmin   6208 Apr 27 10:56 patients.18.csv
      -rw-r--r-- 1 sysadmin sysadmin   6236 Apr 27 10:56 patients.8.csv
      ```

See further reading on [backup-manager](<http://manpages.ubuntu.com/manpages/bionic/man8/backup-manager.8.html>) and [Amanda](<http://www.amanda.org/>), which can also be used for incremental backups.


---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  

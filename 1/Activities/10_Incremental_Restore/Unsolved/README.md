## Activity File: Restoring Data with Incremental Backups

- In this activity, you will continue as a junior administrator at _Rezifp Pharma Inc_ where the E-Prescription Treatment database was attacked. Fortunately, the team had a recent full backup to recover the database.

- However, a pharmacy technician noticed that some files in the Patient database were missing and the team discovered that the wrong full backup was used. You extracted the files from the Patient directory in the correct archive and placed them in a directory for review.

- The pharmacy technician has reviewed and approved the files.  The head of the pharmacy technician department decides that these files can be placed in the Patient directory so another full backup restoration will not be needed.

- Your team performs hourly incremental backups of the E-Prescription Treatment system and will check this backup to ensure the files are added.

- However, a pharmacy technician noticed that some files in the Patient database were missing, because the wrong full backup was used. To correct the issue, you located the correct archive, i.e. full backup, extracted the Patient directory, and placed it in a directory for review.

Your team must do the following in the test environment:

- Perform a level 0 backup of the E-Prescription Treatment directories. 

- List the contents of the level 0 backup.

- Copy the extracted missing files to the Patient directory and validate that the files are added.

- Perform an incremental backup using the current snapshot file.

- List the contents of the incremental backup to check that the missing files are present.

- Remove the missing files from the Patient directory.

- Restore the system from the incremental backups. 

- List the contents of the Patient directory to see that the deleted files were added by the incremental backup.

### Instructions

To start this activity, review what you've learned about _full_ and _incremental backups_ by working with your partner to answer the following questions:

**Review Questions**

1. Briefly describe the difference between a full and incremental backup.

2. If you have a backup schedule of Monday, Tuesday, Wednesday, Thursday, and Friday:  

    - On what day would you schedule a level 0 backup to be done?

    - In what order should the backups be applied to restore a system that was completely lost after an attack?

3. What command would you use to create a level 0 backup of `archive/home/user1`? 

4. What command would you use to list the contents of an incremental backup?

5. After listing the contents of an incremental backup, what do the following letters indicate?

    - **`Y`** indicates that _______.

    - **`N`** indicates that _______.

    - **`D`** indicates that _______.

Now you will start the test of the incremental backup restoration.  

### Incremental Backup Restoration

- If you are not already logged on, please log into the lab environment with:

    - Username: `sysadmin`  
    - Password: `cybersecurity`

1. Move into the `~/Documents/epscript/testenvir` directory and list the contents. Note the contents and then move back up to the `epscript` directory.

2. In your `~/Documents/epscript` directory, create the level 0 backup of the `testenvir` directory, which contains the `doctor`, `patient`, and `treatment` directories.

    - Name the level 0 backup: `epscript_back_sun.tar`

    - Name the snapshot file: `epscript_backup.snar`

    - Remember to include the `tar` option that will **validate the archive after writing it**.

    - Write and execute the command.

3. Write and execute the `tar` command to list the contents of the level 0 backup.

    - What is the status of the files in the backup?

4. Next, let's extract the missing patient files from the `epscript_back_sun.tar` file, save them to a new directory `~/Documents/epscript/restore`, then restore them to the `~/Documents/epscript/testenvir/patient/` directory.

   - **1)** create the new directory `~/Documents/epscript/restore`:

   - **2)** extract the **patient's files** to the newly created directory `~/Documents/epscript/restore`:

   - **3)** copy extracted files into the `testenvir/patient` directory:

   - Verify that the files have been successfully added to the `testenvir/patient` directory.

5. Move to `~/Documents/epscript` and create an incremental backup that will include the added files.

    - Name the incremental backup: `epscript_back_mon.tar` 

6. List the contents of the `epscript_back_mon.tar` incremental backup.

    - What is the status of the files in the incremental backup?

7. Remove the following files from the `~/Documents/epscript/testenvir/patient` directory:

    - `patients.21.csv`
    - `patients.22.csv`
    - `patients.23.csv`
    - `patients.24.csv`
    - `patients.25.csv`     

8. Next, your team will _apply the incremental backup_ to restore the system.

    - Go back to your `~/Documents/epscript/` directory, where the incremental backup is.

    - **Plan**: which backup file is required to restore the deleted files?

9. Run the command to restore the deleted files.

    - Remember to use the `tar` option to print error messages with the block number in the archive file.

    - List the contents of the `patient` directory after restoration.

---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  

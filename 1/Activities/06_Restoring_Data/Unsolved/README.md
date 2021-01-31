## Activity File: Restoring Data with `tar`

In this activity, you’ll continue as a junior administrator at *Rezifp Pharma Inc*.

- The E-Prescription Treatment database was attacked and the database was taken offline. 

- Fortunately, the team had a recent _full backup_ and was able to recover the database, making the system operational. However, a pharmacy technician noticed that some files in the Patient database were missing, and the team discovered that the wrong full backup was used. The system was taken offline again.

- It is critical that the missing patient files are restored as soon as possible. You have spoken to the pharmacy technician and received a list of the names of patients whose files are missing.  

You have been asked to restore all directories that contain the missing patient files as follows:

- List the contents of an archive to determine what it contains.

- Search inside the archive to locate patient names and confirm that the missing data is in the archive.

- Create a directory to restore the patient data for review.

- Extract only the patient files to the directory so they can be checked by the pharmacy technician. 

- Validate that the archive does not contain errors, using a new `tar` option.

### Instructions 

- If you are not logged in, log into the lab environment using:

    - Username: `sysadmin`  
    - Password: `cybersecurity`

1. Move to the `~/Documents/epscript/backup` directory.

2. List the contents of the directory to display the `20190814epscript.tar` file. You will search this archive for the missing patient data.

3. View the patient directory and files in the archive.

    - List the contents of the archive and display the output to the screen in pages.

    - Locate the names of these patients in the `tar` archive:

        - Mark Lopez
        - Megan Patel

        **Hint**: Untar the file, then use `grep` to locate the patient records on each of the directories. In total, you'll need to run **6** searches. You'll want to use `"[first name],[last name]"` in your `grep` search pattern.

    **BONUS** See if you can accomplish this using a single command to search for "Mark Lopez" and a single command to search for "Megan Patel".

4. Extract the patient directory from the `20190814epscript.tar` archive.  

    - Extract patient data to the `patient_search` directory in the `~/Documents/epscript/backup` directory.   

    - Test for any errors when extracting. This will check the integrity of the archive.

    **Hint:** Find the `tar` option that validates and prints **error messages** with the **block number** in the archive file. [See man page here.](https://www.gnu.org/software/tar/manual/html_section/tar_22.html)

5. List the contents of the `patient_search` directory to check that the patient directory and files were extracted there.   


---

© 2020 Trilogy Education Services, a 2U, Inc. brand.  All Rights Reserved.

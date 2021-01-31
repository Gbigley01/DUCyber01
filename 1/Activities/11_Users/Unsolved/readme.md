## Activity File: Users, Groups, and Password Policies

- In the last activity, we took a brief break from reporting and uninstalled applications using the Windows apps GUI and command line. In this activity, we will return to the command ine to gather more information for our `report.txt` file.

- Your CIO is curious about the groups and password policies on the Windows workstation. Continue retrieving information from this Windows workstation using the `net` command-line utility.

- Please continue to use the **Windows 10 Hyper-V virtual machine**. 

**Note**: Before continuing with your activities, remember to `cd` to the `Desktop/reports` directory.

**Note**: You'll likely want to save all of your working commands into a text file for reference. This way, if you mess up your report, you can `del`ete it easily and re-run the working commands.

### Instructions

1. Enumerate users with `net user`.

2. Find the user `sysadmin`'s password status using `net` and append the output to your report.

3. Enumerate local groups with `net localgroup` and append the output to the report.

4. Enumerate the current password policy using `net accounts` and append the output to your report.

5. Check your updated report.

----

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

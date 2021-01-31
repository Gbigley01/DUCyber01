## Activity File: Creating a Report with `wmic` Output

In this activity, you will continue in the role of junior systems administrator at Good Corp, Inc.

- Your CIO wants you to run `wmic` queries to continue baselining the system, including the Windows edition and the build number.

- You also have to retrieve a list of disk information details.  

- The CIO also wants you to append these results to your `report.txt` file.

Before continuing with your activities, remember to navigate to the `reports` directory you created from the previous activity.

Please continue to use the Hyper-V **Windows 10 virtual machine** as the `sysadmin` user.

### Instructions

**Note** that you'll likely want to save all of your working commands into a text file for reference. This way, if you mess up your report, you can `del`ete it easily and re-run the working commands.

1. Using one command, append the following `wmic` query to your report file as one output:

    - Windows edition
    - Build number

- **Note** that you can run `wmic [alias] get /value` to see the different properties and values that can be retrieved from an alias. So for this one, `wmic os get /value`. 

2. Create a `wmic` query for each of the following aliases and append them to the report:

    - **User account** (`useraccount`) info: name, the security identifier of the user (SID), and description

        - **Note**: Security ID (or `sid`): The security ID of each user account. These are used to identify the groups the user belongs in, to set access control entries, and to bind security descriptors to each user.

    - **Login** (`netlogin`) info: username (caption), number of times user has logged on, and last logon time

        - **Note**:  The `LastLogon` format follows the `yyyy/MM/DD-HH:mm:ss.SSSSSSZ` date and time format. 

        - `.SSSSSSZ` are the milliseconds (`000000` in the output) and timezone (`-300` in the output). 

        - This part of the output follows the `SimpleDateFormat` protocol for denoting date and time.

    - **Windows Update information** (`qfe`) info: update name (caption), description, installed on date, and the hotfix ID. 

- **Note**: Make sure you verify each output before using the `/APPEND:<filename>` switch appending it to your `report.txt` file.

----

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

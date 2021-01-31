## Solution Guide: Creating a Report with `wmic` Output

This activity introduced you to using the `wmic` process in the command line. 

Completing this activity required the following steps:

- Using the `wmic [alias] get /value` call to see all of the available alias options.

- Testing the various alias options, such as `wmic logicaldisk get deviceID`.

- Running `type report.txt` to examine the report's contents.

- Finding SID, and important directories and files.

- Retrieving the number of times all users have logged on, and their last logons.

- Retrieving Windows update information and starting up application lists.

-  Enumerating a list of startup services.

---

Begin by listing all the different values that can be retrieved from the `os` `wmic` alias. 

- Run `wmic os get /value`

- We can see that the operating system edition is `Microsoft Windows 10 Enterprise Evaluation`.

- We can also see the `BuildNumber` is `18363`

Next, append this info to our `report.txt` file. 

- Run `wmic /APPEND:report.txt os get caption, buildnumber`.

  ```console
  BuildNumber  Caption
  18362        Microsoft Windows 10 Enterprise Evaluation
  ```

To find all user's last login information, and all user info, SID, important directories, and files:

- Run `wmic /APPEND:report.txt useraccount get name, sid, description`

  ```
  Description                                                                                      Name                SID
  Built-in account for administering the computer/domain                                           Administrator       S-1-5-21-3953285287-1837826134-1402971686-500
                                                                                                   Alex                S-1-5-21-3953285287-1837826134-1402971686-1004
  A user account managed by the system.                                                            DefaultAccount      S-1-5-21-3953285287-1837826134-1402971686-503
  Built-in account for guest access to the computer/domain                                         Guest               S-1-5-21-3953285287-1837826134-1402971686-501
                                                                                                   sysadmin            S-1-5-21-3953285287-1837826134-1402971686-1003
  A user account managed and used by the system for Windows Defender Application Guard scenarios.  WDAGUtilityAccount  S-1-5-21-3953285287-1837826134-1402971686-504
  ```

To find the number of times all users have logged on, and last logon:

- Run `wmic /APPEND:report.txt netlogin get caption, numberoflogons, lastlogon`

  ```
  Caption                       LastLogon                  NumberOfLogons
  NT AUTHORITY\SYSTEM
  NT AUTHORITY\LOCAL SERVICE
  NT AUTHORITY\NETWORK SERVICE
  sysadmin                      20200716131425.000000+000  22
  Alex                          20200220013810.000000+000  3
  ```

To retrieve Windows update information:

  - Run `wmic /APPEND:report.txt qfe get caption, description, installedon, hotfixid`

  ```
  Caption                                     Description      HotFixID   InstalledOn
  http://support.microsoft.com/?kbid=4533002  Update           KB4533002  1/3/2020
  http://support.microsoft.com/?kbid=4513661  Update           KB4513661  10/7/2019
  http://support.microsoft.com/?kbid=4516115  Security Update  KB4516115  10/7/2019
  http://support.microsoft.com/?kbid=4517245  Update           KB4517245  10/7/2019
  http://support.microsoft.com/?kbid=4521863  Security Update  KB4521863  10/7/2019
  http://support.microsoft.com/?kbid=4524569  Security Update  KB4524569  1/3/2020
  http://support.microsoft.com/?kbid=4530684  Update           KB4530684  1/3/2020
  ```

Verify the report by running `type report.txt`. 

----

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

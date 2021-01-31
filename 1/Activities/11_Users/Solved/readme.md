## Solution Guide: Users, Groups, and Password Policies

In this activity, you used the `net` tool to find information about user groups and password policies, and append them to your report.

Start by using `cd` to return to the `Desktop/reports` directory.

-  Enumerate users with `net`.

    - Run `net user >> report.txt`

- Find `sysadmin`'s password status.

    - Run `net user sysadmin >> report.txt`

- Find groups on the machine.

    - Run `net localgroup >> report.txt`

- Find current password policy.

    - Run `net accounts >> report.txt`

- Run `type report.txt` to see the updated report.

----

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

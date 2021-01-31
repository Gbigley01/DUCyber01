## Activity File: Intro to `CMD`

Throughout this day, you will be starting a creating report about this Windows machine. In an upcoming lesson, this Windows workstation will be joined to an Active Directory Domain Controller.

In this activity, you are taking on the role of a junior systems administrator at Good Corp, Inc.

- A senior software developer who recently left the company left behind a Windows workstation that was never centrally managed by IT. 

- Your CIO has requested that you do the following on the Windows workstation:

   - Use Task Manager to clean up running and startup processes.

   - Use `cmd` to create a simple text file in the `%USERPROFILE%\Desktop` directory called `report.txt` to begin appending Windows system information to.

### Instructions 

Start by making sure you're logged into the  **Windows 10 virtual machine** with the following credentials:

- Username: `sysadmin`
- Password: `cybersecurity`

Use Task Manager to complete the following steps:

1. **End** the following processes (*tasks*):

   - `Teamviewer`
   - `Skype`

  **Note** that there may be multiple of these, such as the `Skype` instances.

2. **Disable** all startup processes, *EXCEPT* for the following:

   -  `Git for Windows`
   -  `Microsoft OneDrive`
   -  `Windows Security notification icon`

Complete the following steps in the Windows command line to start your report:

**Create a `reports` folder and a `reports.txt` file with a title and subtitle.**

**Note** that you'll likely want to save all of your working commands into a text file for reference. This way, if you mess up your report, you can `del`ete it easily and re-run the working commands.

3.  Use the command line to create a `reports` folder on the user's desktop where you'll store your findings.

4. Print a line that reads `Baselining Report` and output it to a new `report.txt` file. This will create a title within your report.

5. Print another line titled `Created by [your name here]` and append it to the file.

**Add to the report using ENV variables in the command line.**

6.  Add the OS, date, and user to the report. Using the command line, add the following line to your report: `[operating system] system report created on [today's date] with logged in user, [current username]`, using environment variables in place of the placeholders.

| Environment Variable | Default Value          |
| :------------------- | :--------------------- |
| `%CD%`                 | Current directory      |
| `%DATE%`               | Current date       |
| `%OS%`                 | Windows                |
|` %ProgramFiles%`     | C:\Program FIles       |
| `%ProgramFiles(x86)%`  | C:\Program Files (x86) |
| `%TIME`                | Current time       |
| `%USERPROFILE%`        | C:\Users\{username}    |
|` %SYSTEMDRIVE%`        | C:\                    |
| `%SYSTEMROOT%`         | C:\Windows             |

**Bonus**

- Using the environment variables, `%ProgramFiles%` and `%ProgramFiles(x86)%`, list the contents of these directories and append them to the report.

----

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

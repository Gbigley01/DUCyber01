## Solution Guide: Intro to Task Manager and `CMD`

This activity allowed you to familiarize yourself with ending processes and executing basic command-line operations.

Completing these tasks require:

- Using the Task Manager GUI to perform process maintenance.

- Navigating through the file system with `cd` and `dir`.

- Setting up a `reports` folder on the user's `Desktop` directory using the command line.

--- 

**Ending processes**

- To find what processes are running, we'll launch the GUI tool, Task Manager: 

  - Press `CTRL+ALT+DEL` or navigate to to it through the `Start` menu. 

- Once Task Manager is open, navigate to the `Process` tab and click the `Name` column to sort by process name.

- For each of the following processes, select it, then go to `End task`:

   - `Teamviewer`
   - `Skype`

**Disabling Processes**

- Within the `Startup` tab, select each startup process and `Disable` it, EXCEPT for the following:

   -  `Git for Windows`
   -  `Microsoft OneDrive`
   -  `Windows Security notification icon`

**Create a `reports` folder and an initial `reports.txt` file with a title and subtitle.**

- Open `CMD` and do the following:

  - Run `cd C:\Users\%USERNAME%\Desktop` to navigate to the `Desktop` folder.

  - Run `echo Baselining Report > report.txt` to add the title to the report.

  - Run `echo Created by [your name here] >> report.txt` to add the subtitle.

- Verify your commands worked by entering `type report.txt`.

**Add to the report using ENV variables in the command line.**
- Next, we will append the machine's operating system, date, and username to our report:

  - Run `echo %OS% system report created on %DATE% with logged in user, %USERNAME%. >> report.txt`

  - Run `type report.txt`

    Your output should look like:
    
    ```console
    Baselining Report
    Created by [your name here]
    Windows_NT system report created on Thu 11/14/2019 with logged in user, sysadmin.
    ```

**Bonus**

- Using the environment variables, `%ProgramFiles%` and `%ProgramFiles(x86)%`, list the contents of these directories and append them to the report.

  - Run `dir "%ProgramFiles%" >> report.txt`

  - Run `dir "%ProgramFiles(x86)%" >> report.txt`

----

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

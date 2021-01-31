## Activity File: Removing Windows Bloat with PowerShell Scripts

In this activity, you will be continuing your role as a junior system administrator. 

- As a system administrator, we don't want our users playing games or using unnecessary applications while working. One reason is that these applications can potentially expose personal user email addresses, usernames, or other personal identification information to these Windows Store apps.

- The CIO has tasked us with creating a PowerShell script that will get rid of these Windows bloat applications, and has provided a CSV file containing a list of these applications. 

Use the following files to complete the activity: 

- [Bloat CSV File](Activities/09_Removing_Bloat/microsftbloat.csv)
- [Syntax Reference and Helpful Hints](./Activities/09_Removing_Bloat/tips.md)

You can use a browser window within your VM to retrieve this list:

- [microsoftbloat.csv](https://tinyurl.com/microsoftbloat)

- Please continue to use the **Windows 10 virtual machine** for this activity. 

### Instructions

1. Make sure you have enabled PowerShell scripts with: `Set-ExecutionPolicy RemoteSigned`. 

2. Create a PowerShell script file called `remove_bloat.ps1` in `C:\Scripts` directory.

    - The file can be tested with `.\remove_bloat.ps1` in PowerShell.

    - Use the following template to set up your script:

        ```PowerShell
        <import line here>
        foreach (<condition here>) {
            <PowerShell code block to be executed here>
        }
        ```

3. Import the CSV `microsoftbloat.csv` by assigning the `$csv` variable to the `Import-Csv` cmdlet, with the appropriate parameters.

4. Create a `foreach` condition where a `$line` variable reads each line in the `$csv` variable.

5. Within the code block, have the `Get-AppxPackage` cmdlet retrieve each line's `.appxpkg` field from the `microsoftbloat.csv` CSV file.

    - Make sure to include the `Get-AppxPackage` parameter that retrieves the application for _all users_.

  - Ensure that the `Get-AppxPackage` cmdlet calls the `.appxpkg` with the `-Name` parameter. Make sure to pipe this to `Remove-AppxPackage -Verbose`.

    - When you successfully create and execute the script, PowerShell will show the `Deployment operation progress: ...` output at the top of the terminal and verbose output at the bottom.

**Bonus** 

- Under the get and remove cmdlet pipeline, print a line that states `Windows bloat, {line.name here} removed!` using the proper CSV application name field instead of the placeholder.

  _Hint: If you're not sure what fields exist in the CSV file, open it!_

#### Re-install your applications

Use the following command to re-install your applications for repeat testing. This may take a few minutes to complete:

- `Get-AppxPackage -allusers | foreach {Add-AppxPackage -register "$($_.InstallLocation)\appxmanifest.xml" -DisableDevelopmentMode}`

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

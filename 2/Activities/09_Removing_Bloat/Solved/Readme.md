## Solution Guide: Removing Windows Bloat with PowerShell

For this exercise, we used conditionals in a PowerShell script to delete default Windows apps that add bloat to the system and increase the attack surface of the system. 

Completing this activity required the following steps: 

- Use the cmdlet `Import-Csv` to import a CSV file as an object into PowerShell.

- Create a `foreach` condition that loops through each line, for the application name field, in the CSV file.

- On every loop, execute a two-part cmdlet pipe that first retrieves each application object by name and then sends it to the `Remove-AppxPackage -Verbose` cmdlet to uninstall it.

---

First, make sure we're working from the `Scripts` directory.

- Run `cd C:\Logs`

Next, we'll create a `removebloat.ps1` file.

- Create a file in your preferred text editor and save it as `removebloat.ps1`.

We'll need a line for importing the CSV file.

- Type `Import-Csv -Path ./microsoftbloat.csv`

Construct the `foreach` condition.

- Start a PowerShell `foreach` loop template:

    ```PowerShell
    foreach () {

    }
    ```

Set our condition. In this case, we're calling the CSV file using a variable and reading each line.

- Enter `$line in $csv` in the parentheses.

Now we need the part of the code block that executes for each line that is read.

- Enter `Get-AppxPackage -Name $line.appxpkg | Remove-AppxPackage -Verbose` in the code block.

- After the pipeline, add the following: `Write-Output Windows bloat, $line.name removed!`.

Your final script should look like this:

```PowerShell
$csv = Import-Csv -Path .\microsoftbloat.csv
foreach ($line in $csv) {
    Get-AppxPackage -Name $line.appxpkg | Remove-AppxPackage -Verbose
    Write-Output Windows bloat, $line.name removed!
}

```

When we execute this script, we should expect PowerShell to notify us of application deployment (or in this case, removal) at the top of the PowerShell Window.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
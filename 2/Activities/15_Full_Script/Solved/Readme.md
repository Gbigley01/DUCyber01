## Solution Guide: The Final Script

For this script to function, it needed to do the following:

  - Create the event logs for each type of log as `json` files, with a maximum of 50 events.

  - Establish a session with a `$Session` variable.

  - Use a `$log` variable to store each item in our `Logs` directory.

  - Use a `foreach` loop that, for each item in our `Logs` directory, uses `Copy-Item` to send the file `$log` over our remote PowerShell session.

  - Use an echo line to show us, in PowerShell's console output, each file name that gets sent over.

  - End the session.

The final script should look like this:

```PowerShell
Get-WinEvent -LogName Security -MaxEvents 50 | ConvertTo-Json | Out-File -FilePath "C:\Logs\RecentSecurityLogs.json"
Get-WinEvent -LogName Application -MaxEvents 50 | ConvertTo-Json | Out-File -FilePath "C:\Logs\RecentApplicationLogs.json"
Get-WinEvent -LogName System -MaxEvents 50 | ConvertTo-Json | Out-File -FilePath "C:\Logs\RecentSystemLogs.json"

$Session = New-PSSession -ComputerName 10.0.22.4 -Credential "sysadmin"

$logdirectory = ls "C:\Logs\*"

foreach ($log in $logdirectory) {
    Copy-Item $log -Destination "C:\Logs\" -ToSession $Session
    echo "Copied $log to Windows Server C:\Logs directory!"
}

Remove-PSSession $Session

```

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

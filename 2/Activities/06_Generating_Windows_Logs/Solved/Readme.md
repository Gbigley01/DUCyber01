## Solution Guide: Generating Windows Event Log Files with Parameters and Pipelines

In this activity, you were responsible for retrieving recent `security` and `application` logs using PowerShell, transforming them to `json`, and then saving them to `C:\Logs`.

Completing this activity required completing the following steps: 

  - Executing cmdlets with a variety of parameters and parameter values.

  - Piping cmdlets together to transform the PowerShell output.

  - Querying event logs with cmdlets.

  - Selecting the most recent logs cmdlets.

  - Outputting the logs to a `json` file.

--- 

First we need to check the names of the logs we want to retrieve.

- Run `Get-WinEvent -listlog *` to show all log names.

- Scroll to the top to show the `Security` and `Application` log names in the `LogName` column.

- Note the column header `LogName`. This header is also the parameter we need.

Let's add parameters to our cmdlet to retrieve security logs:

- Run `Get-WinEvent -LogName Security -MaxEvents 100` to show only 100 events.

We'll add the `ConvertTo-Json` cmdlet to convert the output to Javascript Object Notation (`json`) format.

- Run `Get-WinEvent -LogName Security -MaxEvents 100 | ConvertTo-Json`

Now let's pipe that output to a file.

- Run `Get-WinEvent -LogName Security -MaxEvents 100 | ConvertTo-Json | Out-File -FilePath "C:\Logs\RecentSecurityLogs.json"`

Since we didn't see any confirmation output, let's check the contents of the logs.

- Run `Get-Content C:\Logs\RecentSecurityLogs.json` to confirm the logs were created.

Now we want the latest `100` events from the `Application` log. Run:

- `Get-WinEvent -LogName Application -MaxEvents 100 | ConvertTo-Json | Out-File -FilePath "C:\Logs\RecentApplicationLogs.json"`

Success!


---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

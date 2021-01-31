## Activity File: PowerShell Remoting 

In a previous activity, we created some `json` formatted log files using the `Get-WinEvent` cmdlet, along with other commands in a command pipeline. Now we're going to transport these log files to a Windows Server directory for our CIO to inspect later.

In this activity, you are playing the role of junior system administrator tasked with transferring log files to a Windows Server directory.

You will construct a script to send the `Get-WinEvent` security log `json` files from your host machine to the Windows Server hyperV machine.

**Hint**: Use `Get-Help` if you need assistance learning new commands. 

- For example, for more information about `Copy-Item`, use `Get-Help Copy-Item -examples`.

The credentials for the Windows Server VM are:
- Username: **sysadmin**
- Password: **p4ssw0rd***

### Instructions

1. Begin by by doing the following: 

    - Ensure that you have the latest help documentation for PowerShell with `Update-Help`.

    - Confirm that WinRM remoting is enabled on your Windows 10 host machine by running `winrm quickconfig`.

    - Add the Windows Server 2019 IP as a trusted host by running the following:

         `Set-Item WSMan:\localhost\Client\TrustedHosts -Value <Windows Server IP>`
 
    - **Note**: If you do not know the IP address of a machine, you can run `ipconfig` on it and grab the value after `IPv4 Address`.

2. Use a remote **interactive** PowerShell session to the Windows Server and create a `C:\Logs` directory. Use your remoting password to start your session.

3. Create a `$Session` variable with `New-PSSession` and the following parameters:

   - `ComputerName` should be set to your `<Windows Server IP>`.
   - `Credential` should be set to `"sysadmin"`.

4. Use the `Copy-Item` cmdlet that uses the variable you just made, and set the destination to the `C:\Logs\` directory in the Windows Server machine.

5. While we didn't cover this in the demo, you are also tasked with adding a new line to our script. 
    - Your CIO wants visual confirmation on the screen after each log transfer, with the following message. Set the following line to appear `"Copied $log to Windows Server C:\Logs directory!"`, using `Write-Output`. This command functions similarly to `echo`, which you've learned before.
    - Set `$log` to `"RecentSecurityLogs.json"` under where you set `$Session`. 
    - You can test this command separately in PowerShell to see how it will look. For example :`Write-Output hello world!`.

6. Don't forget to end the script's session when it's done running.

7. Using an interactive session, log into the remote server to navigate and verify your `RecentSecurityLogs.json` file exists in the Windows Server `C:\Logs\` directory.

8. `exit` from the remote server when done.

#### Bonus 

Try to use the `Invoke-Command` cmdlet to create the `C:\Logs` directory in the Windows Server machine.

- Use `Get-Help` if needed.

- This cmdlet would come _after_ the `$Session` variable is set up, and before the `Copy-Item` cmdlet.

This bonus uses a new parameter, `-ScriptBlock`:

- The `-ScriptBlock` parameter only needs `{mkdir "C:\Logs" -Force}`. But it also needs a session parameter set up. The `-Force` parameter makes sure the rest of the script doesn't fail if the directory already exists.

- To make sure it's creating the `C:\Logs` directory, create an interactive session to delete it before running your script.

#### Troubleshooting PowerShell Remoting

If you're having issues with PowerShell remoting, use the following checklist to troubleshoot:

1. Run `Set-ExecutionPolicy RemoteSigned` on the Windows 10 VM
2. Run `Enable-PSRemoting -SkipNetworkProfileCheck` on the Windows 10 VM
3. Run `Set-Item WSMAN:\localhost\Client\TrustedHosts -Value <Windows Server IP>` on the Windows 10 VM
4. Run `winrm quickconfig` on both VMs
5. Test connection again with `Enter-PSSession -ComputerName <Windows Server IP> -Credential ~\sysadmin` with password: `p4ssw0rd*`

Don't forget to consult your Student Guides for Day 2. You can also use the `Get-Help` cmdlet in PowerShell to find more info about a command. 

- For example: `Get-Help New-PSSession` or `Get-Help Get-WinEvent`.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

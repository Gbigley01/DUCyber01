## Solution Guide: PowerShell Remoting

In this exercise, we were tasked with setting up a `Logs` folder on the Windows Server machine and creating a script that sends our local logs to that machine.

Completing this activity required the following steps:

  - Enable PowerShell remoting to trusted hosts. In this case, the Windows Server IP address.

  - Use `Enter-PSSession` to remotely access the Windows Server and set up a `C:\Logs` directory.

  - Create a script that does the following:

    - Uses a variable to set the `New-PSSession` cmdlet with `-ComputerName` and `-Credential` parameters.

    - Uses a `Copy-Item` cmdlet to copy the `RecentSecurityLogs.json` file made in the previous activity to the `C:\Logs` directory on the remote host, with the following parameters: `-Destination` and `-ToSession`.

    - Uses `Remove-PSSession $Session` at the end of the script to end our remote session as these are persistent sessions.

**Note:** We will be using the example IP address of `<Windows Server IP>`. 

--- 

First, we want to work from our `Logs` directory.

- Run `cd C:\Logs`

Next, we need to log into a manual, interactive PowerShell session with:


- `Enter-PSSession -ComputerName <Windows Server IP> -Credential "sysadmin"`. Enter the password `p4ssw0rd*` when prompted.


- Enter the password `cybersecurity` when prompted.

Create a directory to receive remote logs:

- Run `mkdir C:\Logs` and see confirmation of successful directory creation.

End the session:

- Enter `exit`.

Now, we need to create our script.

- Using Git Bash, create a new file and save it as `log_transfer.ps1`.

Set up the session bits:

- On the next line, type: `$Session = New-PSSession -ComputerName <Windows Server IP> -Credential "sysadmin"`

- This carries all of our session information for any cmdlet that requires information about _to where_ and _as what user_ we're connecting.

Next we need the actual cmdlet to set up the file transferring.

- On a new line, type: `Copy-Item "C:\Logs\RecentSecurityLogs.json" -Destination "C:\Logs\" -ToSession $Session`

Explain that the first argument is where we're sending our local file from. `-Destination` points to our remote location, and `-ToSession` sets up our remote PowerShell session for this script.

Because we no longer need the session, we'll want to end it. 

- Type: `Remove-PSSession $Session` 

- This will make sure that the script ends the session. As a security professional, you want to end your remote sessions when you're done using them.

Your completed script should look like this: 

```PowerShell
$Session = New-PSSession -ComputerName <Windows Server IP> -Credential "sysadmin"

Copy-Item "C:\Logs\RecentSecurityLogs.json" -Destination "C:\Logs\" -ToSession $Session

Remove-PSSession $Session
```

#### Bonus

The `Invoke-Command` cmdlet requires you to specify code to run in curly brackets and a session to send it to. It looks like:

```PowerShell
$Session = New-PSSession -ComputerName <Windows Server IP> -Credential "sysadmin"

Invoke-Command -ScriptBlock {mkdir "C:\Logs\" -Force} -Session $Session

Copy-Item "C:\Logs\RecentSecurityLogs.json" -Destination "C:\Logs\" -ToSession $Session

Remove-PSSession $Session
```



- In this case, after the `-Session $Session` parameter and variable sets up our session, `Invoke-Command` will execute our command to create the directory, `mkdir "C:\Logs\"`. 

- The `-Force` parameter after `mkdir` makes sure that the rest of the script doesn't stop executing if the directory already exists.

Now, let's test it out:

- Save and execute your script in PowerShell with `{path}\log_transfer.ps1`.

- When prompted, enter passwordL `p4ssw0rd*`

Remotely check out these logs with an interactive PowerShell session:


- Enter up a few times and run `Enter-PSSession -ComputerName <Windows Server IP> -Credential "sysadmin"`.
- Enter password when prompted: `p4ssw0rd*`


Move to our log directory.

- Run `cd C:\Logs`

- Run `ls` to show the contents. Our security logs should be there.

Check the contents of our logs.

- Run `Get-Content .\RecentSecurityLogs.json` to show the output.


---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

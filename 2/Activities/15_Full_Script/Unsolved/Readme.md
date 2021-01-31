## Activity File: The Full Script

In this activity, you will compile all the skills learned today to create a script that does the following:

  - Creates logs as `json` files.

  - Establishes a PowerShell session.

  - Transfers each log over to a target machine.

 **Note**: Unlike previous activities, we are not using a CSV file. Rather, we will be working with the individual contents of a directory.

 **Note:** You will need to run the script a directory above the logs that you are trying to send. 

 This is a common operation for system admins and security professionals. It's also a step closer to automation and using re-executable scripts.

### Instructions

1. In the `C:\Logs` directory, create security, application, system, and Windows Defender logs as `json` files, with a maximum of 50 events.

    - Use `Get-WinEvent -ListLog *` if you forget what logs to pull.

    - Windows Defender's parameter value for `-LogName` is `"Microsoft-Windows-Windows Defender/Operational"`. Do not forget the quotes.


2. Create a variable to hold a new persistent session with the following parameters: 

    - `ComputerName`: `<Windows Server IP>`
    - Username: `sysadmin`
    - Password: `p4ssw0rd*`

3. Create a `foreach` loop that loops through each `$log` item in `$logdirectory`.

    - You will need to set a variable, `$logdirectory`, to the results of `ls ".\Logs\*"` above the `foreach` loop.

    -  The `foreach` loop needs to do the following:
      
        - Copies each log to the Windows Server `C:\Logs` directory using the recently created session variable.

        - Prints a confirmation message after each item is copied. (_Hint: Use a variable in the message._)

4.  End the session in the last line of the script.

5. If you finish early, use an interactive session to check the remote machine's `C:\Log` directory.

--- 
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

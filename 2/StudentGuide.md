## 7.2 Student Guide: PowerShell Scripting
 
### Lesson Overview

Today's class will introduce the PowerShell command-line shell and scripting language.
You will be learning how to use Powershell to create and execute various scripts for system administration.

### Class Objectives

By the end of today's class, you will be able to:

- Use basic PowerShell cmdlets to navigate Windows and manage directories and files.

- Use PowerShell pipelines to retrieve Windows system event logs.

- Combine various shell-scripting concepts such as cmdlets, parameters, piping, conditions, and importing files with data structures. 

### Slideshow 

The slides for today can be viewed on Google Drive here: [7.2 Slides](https://drive.google.com/open?id=1u1x--37_5rFFRbhcvi6MGQ-Ur_e7LJxMp242g_92oXo)

* Note: Editing access is not available for this document. If you wish to modify the slides, please create a copy by navigating to File > "Make a copy...".


### Lab Environment

For today's demonstrations, we will be using the Windows 10 and Windows Server virtual machines within out Hyper-V lab machine.

- Credentials for the Windows Server VM:
  - Username: `sysadmin`
  - Password: `p4ssw0rd*`

- Credentials for the Windows 10 VM:
  - Username: `sysadmin`
  - Password: `cybersecurity`

Because we are using a virtualized environment for the Windows 10 machine, the screen resolution may not fill the entire screen during demos. 

To adjust screen resolution:

- Log into the Windows 10 VM and right-click anywhere on the screen.
- In the new tab that opened scroll down to **Display Settings**. 
- A new **Display** window will pop up. Navigate to **Display resolution** and adjust the resolution to match your screen from here.

#### Saved State Clearing

**NOTE:** Hyper-V VMs should be shut down after every session to avoid the HyperV Machine going into a hibernation known as a 'Saved State'. If a machine goes into a saved state, you may see the error `The application encountered an error while attempting to change the state of the 'VM-Name'.` 

If you see this error, the VM may not startup until you _delete the saved state_. Turning the VMs and the host machine off when not in-use will avoid this troubleshooting overhead.

To delete the saved state, run the following PowerShell line to clear the Hyper-V virtual machine _saved states_:

- `Get-VMSnapshot | Remove-VMSavedState`.

**NOTE:** If you are unsure how to launch PowerShell, click on to the bottom left `Start` menu button and type "PowerShell".

**NOTE** that if, at any point, you come across an error that says `The application encountered an eror while attempted to change the state of...` when starting up your virtual machines, you rill need to run `Get-VMSnapshot | Remove-VMSavedState` again.

After deleting the saved state, you can turn on the **Windows 10** and **Windows Server** virtual machines by running:

  - `Get-VM | Start-VM`

#### Speeding up the Windows 10 VM

The Windows 10 virtual machine may seem slow and unresponsive. If this is the case for your class, run the following steps within the Windows 10 VM:

- Open `Task Manager` by going to the Start menu and typing "Task Manager" and hitting enter.

- Go to the `Startup` tab and click the `Microsoft Windows Based Host Script` and then click `Disable`.

  - Disable the rest of the `Startup` items for improved performance, as desired. This includes items such as `Steam` and `Skype`.

- Reboot the Windows 10 virtual machine.

### 01. Welcome and Overview 

#### What is PowerShell?

Today, we will be covering PowerShell, the successor to `CMD`. 

- PowerShell is a powerful scripting language that allows people to locally and remotely manage Microsoft products, which come with PowerShell support built-in.

- Because the Microsoft enterprise suite of products is the most widely used by organizations, it is critical that system administrators and security professionals know how to use PowerShell.

- PowerShell can be used to lock down and harden enterprise networks. But because PowerShell's capabilities are powerful for managing enterprise Windows systems, they can be leveraged by offensive security professionals and malicious actors.

Some professional career context as it relates to PowerShell:
**PowerShell in system administration**: PowerShell can be used to manage everything in a Microsoft enterprise environment, including:

- **Windows Server**: Microsoft's central server for domain and networking services.
  - This includes managing users and network resources, such as a file-sharing server.
  - Certain types of Windows servers, such as domain controllers are central components to an enterprise network. They maintain control and permissions of all users within Microsoft-based enterprises. It's vital to keep these servers secure. We'll learn more about domain controllers next class. 
  - A compromised domain controller is a worst-case scenario for most organizations.

- **Windows 10**: Microsoft's personal and professional computer operating system. Windows 10 is the ubiquitous operating system used by most people and within many large enterprise environments. It comes in various "editions", such as `Pro` or `Enterprise`, each adding some functionality, such as access to `Hyper-V`. 
  - Note that because Windows is the most widely used operating system, it is also the ones attackers try to find as many vulnerabilities for.

  - **Windows 7** is officially unsupported by Microsoft, meaning, that if a vulnerability is found for Windows 7, Microsoft may not release a patch for those systems to automatically retrieve and update.

- **Office365**: Microsoft's line of subscription office services.
  - It is probable that you've used one of these products, such as Microsoft Word or Excel.
  - These products tend to be vectors of attack by malicious actors due to their widespread use. The most sophisticated attacks will incorporate PowerShell in some form or another.

- **Azure**: Microsoft's cloud services.
  - Azure provides a wide array of cloud services such as virtual private clouds or cloud-based virtual machines, like the one you're using right now.

**PowerShell in cybersecurity**

- **Defensive security**: PowerShell can be used to manage and audit logs. There are many commands for interacting with Windows Event logs. We will be looking at these later.

  - PowerShell can also be used to harden the security on Windows hosts and servers. There are many modules and scripts that extend PowerShell's powerful functionality to enforce cybersecurity policy.

- **Offensive security**: PowerShell is often used as a "living off the land" tool, meaning it is a tool that exists on the target's computer that can be leveraged by attackers.

  - Once a system is breached, Powershell is often used to retrieve a wide array of information within a network, such as user and server names. It can also be used to access and maintain access on other networked machines, if they are not properly secured.

#### Comparing Powershell and `CMD`

While `CMD` allows one to interact with Windows, its functionality is limited:

- `CMD`'s output is only available in simple text format. Our only option for unsupported file formats is to edit the output with meticulous character replacing. It's kind of like using Wite-Out to edit a printed document over and over.

- `CMD`'s command flags can be ambiguous and confusing. Each tool has its own flags. Let's look at two commands that use the `/s` and `/d` flags:

  - `shutdown /s` shuts down a computer.

  - `freekdisk /s` specifies the name of an IP or remote computer to check disk space.

  - `shutdown /d` specifies a reason for shut down.

  - `freedisk /d` specifies which disk drive to check.

PowerShell remedies this inconsistency with clearly defined parameters for each command. This makes PowerShell more predictable, easier to write, and easier to read.

- `Stop-Computer -Confirm`

  - This command will ask you to confirm that you really want to shut down the computer. However, running tasks may prevent the shutdown from occurring.

- `Stop-Computer -Force`

  - This command will immediately shut down the computer regardless of what is running. This will ignore the usual tasks that can prevent a graceful shut down, such as large file transfers and 3D applications.

#### PowerShell Piping for `CMD`'s Un-Supported Operations

Another issue with `CMD` is that it doesn't easily support certain operations.

In the next example, we'll have you run a complex `CMD` `batch` file and compare it to a simple Powershell alternative.

- If we want to find the file sizes of subdirectories in `C:\Windows\System`, we need a complex `CMD` `batch` file.

- On the host windows machine (not a HyperV VM), open powershell by searching for it in the windows search bar on the task bar.

- Open `cmd` as well and put the two windows next to each other.

- In `CMD` run `type C:\windows\filesizes.bat` to show it's contents.

Your output should be:

    ```batch
    @echo off
    set size=0
    for /r %%x in (System\*) do set /a size+=%%~zx
    echo %size% Bytes
    ```

- The `batch` file would need to be in the `C:\Windows` directory when the command is run.

- In `CMD`, run `C:\Windows\filesizes.bat`. 

PowerShell can do this same task using a simple `|` pipe.

- In Powershell, Type `dir C:\Windows\System -Recurse`.

  - We can run `dir C:\Windows\System -Recurse` to grab all the current directory and subdirectories' contents.

  - Then, we can **pipe** that output to a command that will measure the files for us.

- Type out the rest of the command: `dir C:\Windows\System -Recurse | Measure-Object -Sum Length`

  - `Measure-Object` command receives all the previous inputs and returns the sum of all the file sizes. It does this more accurately than `CMD`.

- Run the command to see the results:

    ```console
    Count    : 3
    Average  :
    Sum      : 31039
    Maximum  :
    Minimum  :
    Property : length
    ```

#### Differences Between CMD and PowerShell

The `CMD` batch script required that a default file size was set to 0, 
- Then it took a long time to individually find the file sizes within the subdirectory.
- It then read each of those text strings and added them to the original file size. 

This is a very inefficient and inelegant way to script. The script is also very unreadable.


The PowerShell pipe already knew that file sizes were a type of property that a directory or file can have. 
- `dir` grabs all of the directories and files recursively. 
- Then the `Measure-Object` is used to only retrieve the file sizes of the files and directories.  
- Then, we simply used arguments such as `-Sum Length`, which totalled the file sizes.

In PowerShell, these things that have defined properties, such as case files having filesize, are known as **objects**.

#### PowerShell and Objects

**Objects** are things with properties or attributes.

- PowerShell innately understands and interacts with everything as an object with attributes or properties.

Let's look at the following example:

- Run `ls C:\Windows`

- Each file and directory is being processed by Powershell as an object, each with its own properties.

  - For example: The file's name is a property of a file: `file.name`.

Now we'll use a pipe to retrieve only the objects whose `name` property has the word "system" in it.

- Type: `ls C:\Windows | Where-Object {$_.name -like "*system*"}`

  - In this example, PowerShell will return the contents of a directory as objects.
  - It will look through their `.name` properties for the word "system."

  - `$_` means _previous object_. In this case, the previous objects are all of the files and directories under `C:\Windows`.



- In summary, we are passing the objects of `ls C:\Windows` to the `Where-Object` command to be filtered down to names that contain "system."

Run the command to see the results:

```
PS C:\Users\sysadmin> ls C:\Windows | Where-Object {$_.name -like "*system*"}

    Directory: C:\Windows


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        3/19/2019   4:52 AM                System
d-----        1/30/2020   5:58 PM                System32
d-----        3/19/2019   6:22 AM                SystemApps
d-----         1/9/2020   9:22 PM                SystemResources
-a----        3/19/2019   4:49 AM            219 system.ini
```

- **Note:** Results may slightly vary.

Understanding how objects work is important for sysadmins and security professionals interacting with Microsoft products.

#### More PowerShell Advantages and Aliases

Let's cover some more of Powershell's advantages:

- PowerShell commands are extensively documented. There are multiple ways to make sure you're using the right commands with PowerShell's extensive internal documentation system.

- PowerShell uses **aliases** to mimics UNIX commands like as `ls` and `cat`.

  - Running `Get-Alias ls` will provide the PowerShell cmdlet counterpart for Unix commands. 

  - **Note** that these function differently than their UNIX counterparts when it comes to options, arguments, etc. For example, `ls` works but `ls -la` does not. 

- Despite being a Microsoft product, PowerShell is officially open source and available on GitHub. In contrast, there is no source code available for `cmd.exe` and writing tools for `CMD` is limited compared to PowerShell.  

### 02. Intro to PowerShell 

Please use the **RDP Host** for this section's demos. 

In this lesson, we are going to continue our sysadmin tasks by readying a Windows 10 workstation for new users.

- Our CIO tasked us with readying the Windows 10 workstation through the command line and GUI. Today, the CIO asked us to use PowerShell to complete the following activities:

  - Navigate Windows with the PowerShell command line.

  - Create **logs** with PowerShell.

  - Create **scripts** with PowerShell.

  - Learn how to **remote** with PowerShell.

- Eventually these logs can be transferred to a central logging repository for SIEM integration. We'll learn about SIEMs more in a later unit.

#### An Introduction to PowerShell's Syntax

Let's get started by looking at Powershell's syntax.

- First, we are going to learn how to use PowerShell commands, otherwise known as **cmdlets** (pronounced "command-lets").

#### Cmdlets

Cmdlets are the combinations of PowerShell **verbs** and **nouns**. This is part of what makes PowerShell easy to use.

- Some cmdlets are equivalent to Linux's commands.

Make sure the reference the attached [CheatSheet](CheatSheet.md).

  | CMDlet          | Function                                         | Equivalent Command     |
  | --------------- | ------------------------------------------------ | ---------------------- |
  | `Set-Location`  | Changes to specified directory                   | `cd`                   |
  | `Get-ChildItem` | Returns current directory's contents             | `ls`, `dir`            |
  | `New-Item`      | Makes a new directory                            | `mkdir`                |
  | `Remove-Item`   | Deletes a file or directory                      | `rm`, `rmdir`          |
  | `Get-Location`  | Retrieves path to current directory              | `pwd`                  |
  | `Get-Content`   | Returns file contents                            | `cat`, `type`          |
  | `Copy-Item`     | Copies a file from one given location to another | `cp`                   |
  | `Move-Item`     | Moves a file from one given location to another  | `mv`                   |
  | `Write-Output`  | Prints output                                    | `echo`                 |
  | `Get-Alias`     | Shows aliases for the current session           | `alias`                |
  | `Get-Help`      | Retrieves information about PowerShell commands  | `man`                  |
  | `Get-Process`   | Gets processes running on local machine          | `ps`                   |
  | `Stop-Process`  | Stops one or more defined process(es)            | `kill`                 |
  | `Get-Service`   | Gets a list of services                          | `service --status-all` |

We'll start with some navigation commands and then work our way to creating event logs.

#### Verb-Nouns

Consider the following scenario:

- User `Alex` left our company. We need to remove their user account from the system. However, Alex has an unfinished `reports` directory on their account.

- Before removing the account, we need to move the `reports` directory and files from their Desktop directory to a directory that will remain after we remove the account.

- Along the way, we'll use some other useful Powershell commands as well.

First, lets change the current working directory to the reports directory we worked on in the last class.

- Run: `Set-Location C:\Users\Alex\Desktop`

These commands follow a verb-noun format.

- The verb in this case is `Set`.
- The noun is `Location`.
- In other words, we are setting the location of our terminal to `C:\Users\Alex\Desktop`. 
  - This is the same as `cd` in Linux, which is also an option to use with Powershell.

Next, we want to move the reports logs from the `Alex`'s desktop to the `C:\` drive. We can do this with `Move-Item`.

- Type `Move-Item reports C:\`

- The verb here is `Move` and will act on a noun, `Item`, which can be a file or directory. 
  - This is the same as `mv` in Linux.

- Run the command.

We can check the contents by using the cmdlet `Get-ChildItem`.

- Run `Get-ChildItem C:\`.

- This command will retrieve all the "child" items of the designated parent path, `C:\`.
- Our verb in this case is `Get` and our noun is `ChildItem`. 
  - You can also use `ls`, just like in Linux.

Now we've moved our `reports` directory outside of the user's desktop directory to `C:\`, so that we can later delete the user account but retain the reports.

A few other commands worth noting:

To create an **item**:

- Run `New-Item demo_file`

- The created item defaults to a file object. This is the same command as `touch` in Linux.

Run the command and then run `Get-ChildItem` to show the directory's contents.

Since this is a demo file and we want to delete it, we'll use `Remove-Item`.

- Run `Remove-Item demo_file` to delete the file.

- Run `Get-ChildItem` to see it's no longer there.

Now we can navigate anywhere, and create and delete files. Let's look at some slightly more complex commands.

#### Parameters

In the previous section, we used the `New-Item` cmdlet to create an object with the item-type _file_. This is the default behavior of `New-Item`—to act like the Linux command `touch`. 

But what if we want the item-type to instead be a _directory_ with a specific name and location? (This would be achieving the same effect as `mkdir`.) We can do that by adding parameters to `New-Item`.

Let's look at how to use `New-Item` with parameters to set up a new directory to store the logs we will generate.

- Type `New-Item -Path "C:\" -Name "Logs" -ItemType "Directory"`

This command is a little more complicated but will be straightforward once they look more closely. This is the beauty in PowerShell's predictable and descriptive commands.

Syntax breakdown:

- `New-Item` is similar to `Move-Item` in that it can create a file, or, now, a directory.

- `-Path` is the parameter specifying which directory we want our new item created in. In this case, `C:\`.

- `-Name` is the parameter specifying what we want to name this new item. In this case, `Logs`.

- `-ItemType` lastly, is the type of `item` we want to create. If we don't specify `"Directory"` it will default to file, like before.

The parameters `-Name` and `-ItemType` modify the original function of `New-Item` by altering the object it will create.

Now we should see a directory, `Logs`, created in `C:\`.

- Run the command to show the confirmation output.

We can verify this once again by using the cmdlet `Get-ChildItem`.

- Run `Get-ChildItem C:\` to show the newly created `Logs` directory.

With the power of PowerShell parameters, we can achieve the effects of `touch` and `mkdir` commands with the `New-Item` cmdlet.

##### More Examples

We'll run through some more examples of parameters in PowerShell.

- Press the `UP` key or again type `New-Item -Path "C:\" -Name "Logs" -ItemType "Directory"`.

If we were to enter the same command again, even though `Logs` already exists, it will error out and the command will not be processed. 

- Run the command to see the error message: `New-Item : An item with the specified name C:\Logs already exists.`

There is a way to run `New-Item` commands like this that will prevent errors, with the parameter `-Force`.

- Run `New-Item -Path "C:\" -Name "Logs" -ItemType "Directory" -Force`

This command will not error out when run.

If we are looking for commands with the word "process" in it, they can run `Get-Command`.

- Type `Get-Command -Name *Process`

`*Process` is a wildcard parameter value that we're giving to the parameter `-Name`. This means _give me all the commands with the word "process" in it._

- Run the command to see the output of all commands with "process" in their name.

```
PS C:\Users\sysadmin> Get-Command -Name *process
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Get-AppvVirtualProcess                             1.0.0.0    AppvClient
Function        Start-AppvVirtualProcess                           1.0.0.0    AppvClient
Cmdlet          Debug-Process                                      3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Enter-PSHostProcess                                3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Exit-PSHostProcess                                 3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Get-Process                                        3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Start-Process                                      3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Stop-Process                                       3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Wait-Process                                       3.1.0.0    Microsoft.PowerShell.Management
```

What if we wanted to run an administrative `CMD` session from PowerShell?

- Run `Start-Process -FilePath CMD -Verb RunAs` to launch `CMD`.

- Run `Stop-Process -Name CMD` to close CMD.


### 03. Move and Create Directories Activity 


- [Activity File: Move and Create Directories](Activities/03_Move_and_Create_Dir/Unsolved/Readme.md)

### 04. Review Move and Create Directories


- [Solution Guide: Move and Create Directories](Activities/03_Move_and_Create_Dir/Solved/Readme.md)


### 05. Generating Windows Event Log Files with Parameters and Pipelines 

In the previous activity, we used parameters to modify various PowerShell cmdlets. We're going to build on parameters further by chaining commands using pipelines.

- Chaining commands is important in sysadmin and security roles. For example, quickly retrieving and sorting through various logs is a common task.

In the next demo, we will continue our role as a junior system administrator. Our CIO has asked us to retrieve multiple types of logs from our Windows 10 machine and save them as `json` files in our newly created `C:\Logs` directory, so they can later be imported to a Splunk SIEM for the company's analysts.

For our next demo we are going to chain cmdlets together to create a PowerShell pipeline that does the following:

- Retrieves Windows logs from Windows Events.

- Transforms the logs to the structured data format `json`.

- Outputs these files to the `C:\Logs` directory we made in the last activity.

#### Powershell Pipeline Demo

First, let's learn the command for retrieving the Windows Event log from Windows 10.

- Type `Get-WinEvent`

Windows Event logs are recorded instances and information of events that occur in Windows, such as date and time of event, criticality of event, what happened during the event (e.g., a service starts), etc.

- Run the command and see the huge amount of scrolling, unsorted logs. This output could take days to finish (or error out).

- Enter `CTRL+C` to stop the output.

`Get-WinEvent` is a cmdlet that requires parameters to retrieve a manageable amount and types of logs.

- For example, adding `-LogName` followed by the name of a log, e.g., "Security," will only show us the `Security` logs. So let's clear our screen and try again.

- Run `clear` in console to clear the screen.

Now, we're going to get a list of all log categories instead of every log ever created.

- Type `Get-WinEvent -ListLog *`

- The asterisk `*` is a wildcard indicating everything after the `-ListLog` parameter, so it will return every log that we can retrieve with `Get-WinEvent`.

- Run the command to see the available list of logs.

- Scroll up and notice the `System` logs under the `LogName` column (it should be in the first few results):

  ```PowerShell
  LogMode   MaximumSizeInBytes RecordCount LogName
  -------   ------------------ ----------- -------
  Circular            15728640        4513 Windows PowerShell
  Circular             1052672           0 Windows Azure
  Circular            20971520       12661 System
  Circular            20971520       27813 Security
  ...
  ```

  - **Note:** Results may vary.

If we want to find specific logs, such as System, we can use the `-LogName` parameter to specify which ones.

- Run `Get-WinEvent -LogName System` to return System logs.

- It should be scrolling for a long time.

- Enter `CTRL+C` to stop the output.

Since there are _thousands of logs_ and PowerShell will attempt to retrieve _all_ of them, we'll need to narrow down that list using parameters.

- Type `Get-WinEvent -LogName System -MaxEvents 10`

  - By adding the `-MaxEvents` parameter and the value `10`, we should now see only up to 10 logs.

- Run the command and notice how much more manageable this is. 

#### Piping Logs to JavaScript Object Notation with `ConvertTo-Json`

Now that we used parameters to get the logs we need, we will output them into a file that can be used later by log analysis applications. This is where pipelines come in. But we also need to pick a file format.

- The `json` (_JavaScript Object Notation_) structured data format can be easily read and manipulated by today's most common scripting and programming languages.

- Windows logging systems understand `json`, so we will be converting our logs to this file format.

Now, we will convert these logs to the `json` data format using the `|` character, just like in Linux.

- Type `Get-WinEvent -LogName System -MaxEvents 10 | ConvertTo-Json`

-  The output from `Get-WinEvent` is sent to `ConvertTo-Json`. One cmdlet's output becomes the input for the next.

- Run the command to show the slightly less readable, but highly structured `json` logs. 

  ```
  PS C:\Users\sysadmin> Get-WinEvent -LogName System -MaxEvents 10 | ConvertTo-Json                                     [
      {
          "Id":  13,
          "Version":  0,
          "Qualifiers":  null,
          "Level":  4,
          "Task":  1003,
          "Opcode":  0,
          "Keywords":  -9223372036854775808,
          "RecordId":  2555,
          "ProviderName":  "Microsoft-Windows-Hyper-V-Netvsc",
          "ProviderId":  "152fbe4b-c7ad-4f68-bada-a4fcc1464f6c",
          "LogName":  "System",
          "ProcessId":  3360,
          "ThreadId":  9036,
          "MachineName":  "DESKTOP-U3FCUKI",
          "UserId":  null,
          "TimeCreated":  "\/Date(1595374458918)\/",
          "ActivityId":  null,
          "RelatedActivityId":  null,
          "ContainerLog":  "System",
          "MatchedQueryIds":  [
                              ],
          "Bookmark":  {
                       },
          "LevelDisplayName":  "Information",
          "OpcodeDisplayName":  "Info",
          "TaskDisplayName":  null,
          "KeywordsDisplayNames":  [
                                   ],
          "Properties":  [
                             "System.Diagnostics.Eventing.Reader.EventProperty",
                             "System.Diagnostics.Eventing.Reader.EventProperty"
                         ],
          "Message":  "Miniport NIC \u0027Microsoft Hyper-V Network Adapter #3\u0027 disconnected"
      }
  ```

- **Note:**  Output may vary.

- This command transformed the output of `Get-WinEvent` to `json` with `ConvertTo-Json`.

Our logs aren't actually in a file yet, so we will need a cmdlet that will send this output to a file.

- PowerShell has a cmdlet for this, called `Out-File`. 

- This cmdlet uses the `-FilePath` parameter to designate the location for the output file. Let's name this file `RecentSystemLogs.json`.

So let's go back to the `json`-converted logs and add the `Out-File` cmdlet and specify a path with `-FilePath`.

- Type `Get-WinEvent -LogName System -MaxEvents 10 | ConvertTo-Json | Out-File -FilePath C:\Logs\RecentSystemLogs.json`

- This command will send our `json`-transformed output to a file called `RecentSystemLogs.json` in the `C:\Logs` directory. Remember, Windows file paths use backslashes instead of forward slashes.

Let's verify that this command worked.

- Navigate to `C:\Logs` with `Set-Location C:\Logs`.

- Run `Get-ChildItem` to confirm `RecentSystemLogs.json` exists in the current directory.

- Run `Get-Content .\RecentSystemLogs.json` to confirm we now have logs in the `C:\Logs` directory.

### 06. Generating Windows Event Log Files with Parameters and Pipelines Activity

- [Activity File: Generating Windows Logs](Activities/06_Generating_Windows_Logs/Unsolved/Readme.md)

### 07. Review Generating Windows Event Log Files with Parameters and Pipelines

- [Solution Guide: Generating Windows Logs](Activities/06_Generating_Windows_Logs/Solved/Readme.md)

### 08. Scripting with PowerShell 

We highlighted the importance and convenience of Linux scripting in our recent units on system administration.

- Scripts allow sysadmins and security professionals to automate and execute basic to advanced procedures and operations.

- We can do everything from setting basic firewall rules to standing up entire cloud virtual machine environments with networking, storage, and users.

PowerShell, like Linux, allows us to script many commands in sequence.

- For example, suppose you were tasked to set up Windows workstations for users in the accounting department. You could create a script do the following, in this order:

  1. Pull sensitive accounting data and files to a specified directory from a file server.

  2. Download AppLocker, a program for limiting and controlling access to files for certain users and groups.

  3. Deploy application control policies for AppLocker to restrict user access to the directory so only people in the `accounting` group can access it.

In the following demonstration, we will use scripts to remove unnecessary applications and potential security hazards from Windows workstations.

#### Re-staging the Microsoft bloat

After prepping for the day, if you ran the `removebloat.ps1` script, you can re-stage your Microsoft Store Apps by running: 

- `Get-AppxPackage -allusers | foreach {Add-AppxPackage -register "$($_.InstallLocation)\appxmanifest.xml" -DisableDevelopmentMode}`

#### Demo Scenario: Scripting the Removal of Windows Bloat

In this demonstration, we will create a script in `Git Bash`'s `nano` to remove Microsoft `Skype`.

- Windows 10 has been notorious for implementing a lot of privacy-invasive settings and preinstalled bloat applications that have been considered largely unnecessary and potential vectors of attack.

- Some of these settings include `telemetry tracking` and `advertising IDs` while some of the default installed applications include `Skype`.

- We want to remove these applications to reduce the attack surface area for this workstation. Instead of trusting our users to not use these apps, we're going to remove the possibility of it being exploitable, entirely.

- If curious, you can read the following links detailing potential security and privacy vulnerabilities of seemingly harmless applications: "North Korean hackers infiltrate Chile's ATM network after Skype job interview": https://www.zdnet.com/article/north-korean-hackers-infiltrate-chiles-atm-network-after-skype-job-interview/

We will look at the parameters and piping needed to remove `Skype`. These will later be used in a PowerShell script to remove many more applications all at once.

In the upcoming demo, we have been tasked by our CIO with doing the following:

- Use a cmdlet in PowerShell to allow their scripts to run.

- Create a PowerShell script file and execute it.

- Use a cmdlet to import various items to interact with in a PowerShell script.

- Use a `foreach` loop to go through each item in that imported CSV file.

**Important**: For the upcoming PowerShell script demos and activities, the scripts will be written in `Git Bash` using `nano` and then run using PowerShell. This is so you do not have to learn another text editor and can use `nano` which you are already familiar with. It is advisable that you have a `Git Bash` window open alongside a PowerShell window for the demos. 

#### Demo: Enabling PowerShell scripts

PowerShell script files end with a `.ps1` extension.

- PowerShell, by default, does not allow `.ps1` scripts to be run. This is a security measure to prevent malware, attackers, and improperly constructed scripts from immediately just executing commands en masse, and then compromising a system.

We'll need to enable PowerShell script execution by running the command: `Set-ExecutionPolicy RemoteSigned`.

- Open both a powershell window and a GitBash Window so they are side-by-side.

- In the powershell window, run: `Set-ExecutionPolicy RemoteSigned`.
  - When asked if you would like to change the execution policy, mark `Y`.

By changing the **Execution Policy**, we can now create and run powershell scripts for automation. Although this makes our lives easier it does pose a security risk. If we are infiltrated, or if we run a malicious script we could lose everything on our system. We'll talk more about this in future classes when we get to the offensive side of security.

The steps to creating a script are as simple as creating a file with the `.ps1` extension.

Using GitBash, move into our previously created `Scripts` directory.

- Run `cd C:\Scripts`.

- We will be saving our scripts to this directory.

Now, we'll create a new script that we will run in PowerShell.

- In the Gitbash terminal run: `nano example_script.ps1`

- This command will create a blank file named `example_script.ps1` in the current directory.

#### Demo: Executing a Powershell script

Now we'll now add code to our script to look for the pre-installed Windows Store app, `Skype` as a PowerShell object:

- In the GitBash `nano` document, enter:

  ```PowerShell
  $appxpkg="*Skype*";
  Get-AppxPackage -AllUsers $appxpkg
  ```

The syntax:

- `$appxpkg="*Skype*"` declares the variable `$appxpkg` and assigns the wildcard `"*Skype*"` to it. This will find all the `AppxPackages` that have "Skype" in their name.

- `Get-AppxPackage -AllUsers $appxpkg` retrieves Windows Store applications. More specifically, it retrieves an `AppxPackage` object with the assigned `appxpkg` name "Skype".

- By adding `-Allusers`, this will retrieve the packages for all users.

After we save this file and run it, it should output information about the application `Skype`.

Save the file using `nano`'s 'Write Out' function, so you don't have to close the script.

- Type `CTRL+O` and press enter to save the file without closing `nano`.

In the PowerShell window, navigate to the same directory and run the script.

- Run `.\example_script.ps1`

- The console output should look like:

  ```PowerShell
  Name                   : Microsoft.SkypeApp
  Publisher              : CN=Skype Software Sarl, O=Microsoft Corporation, L=Luxembourg, S=Luxembourg, C=LU
  Architecture           : X64
  ResourceId             :
  Version                : 14.35.152.0
  PackageFullName        : Microsoft.SkypeApp_14.35.152.0_x64__kzf8qxf38zg5c
  InstallLocation        : C:\Program Files\WindowsApps\Microsoft.SkypeApp_14.35.152.0_x64__kzf8qxf38zg5c
  IsFramework            : False
  PackageFamilyName      : Microsoft.SkypeApp_kzf8qxf38zg5c
  PublisherId            : kzf8qxf38zg5c
  PackageUserInformation : {S-1-5-21-3953285287-1837826134-1402971686-1004 [Alex]: Installed,
                           S-1-5-21-3953285287-1837826134-1402971686-1003 [sysadmin]: Installed}
  IsResourcePackage      : False
  IsBundle               : False
  IsDevelopmentMode      : False
  NonRemovable           : False
  Dependencies           : {Microsoft.NET.Native.Framework.2.2_2.2.27011.0_x64__8wekyb3d8bbwe,
                           Microsoft.NET.Native.Runtime.2.2_2.2.27011.0_x64__8wekyb3d8bbwe,
                           Microsoft.VCLibs.140.00_14.0.26706.0_x64__8wekyb3d8bbwe,
                           Microsoft.SkypeApp_14.35.152.0_neutral_split.scale-100_kzf8qxf38zg5c}
  IsPartiallyStaged      : False
  SignatureKind          : Store
  Status                 : Ok
  ```

Success! We have a script to retrieve information about `Skype` installed on our system!

#### Demo: Removing Candy Crush

Now, let's edit our script to remove Skype:

- With `nano` still open, create a pipe that pipes `Remove-AppxPackage -Verbose` after the `Get-AppxPackage` cmdlet:

  ```PowerShell
  $appxpkg="*Skype*";
  Get-AppxPackage -AllUsers $appxpkg | Remove-AppxPackage -Verbose
  ```

We are now sending the results of `Get-AppxPackage` to `Remove-AppxPackage`. On successful execution, we will remove `Skype`.

Save and close the script.

Before running the command pay attention to the top of the console:

- Since we've included `-Verbose`, we will briefly see `Deployment operation progress: ...` at the top of the screen along with all of the background operations to the console that we wouldn't normally see if you were to execute to the command.

- Run the command and notice the `Deployment operation progress: ...` message at the top of PowerShell and the `Verbose:` messages at the bottom.

  ```PowerShell
  PS C:\> c:\example_script.ps1

  VERBOSE: Performing the operation "Remove package" on target "Microsoft.SkypeApp_14.35.152.0_x64__kzf8qxf38zg5c".
  VERBOSE: Operation completed for: Microsoft.SkypeApp_14.35.152.0_x64__kzf8qxf38zg5c
  ```

We've just deleted Microsoft's Skype from our machine. While we could remove the Windows Store apps one by one, it would be more time efficient to create a script that will loop through a list of the apps and uninstall them all at once.

Luckily, we have a file with a list of Windows Store apps called [demo.csv](Resources/demo.csv).

But what's a CSV file?

#### Demo: What's a CSV File?

- A _comma-separated values_, or CSV, file is a plain text file that contains simply structured data, or _fields_, separated by commas.

- CSV files often contain structured lines of information made up of rows of data.

- The top line of a CSV file contains the _header_ or the row that describes each field.

  - For example, you may have the headers "fruit" and "vegetable" with the corresponding field entries, "apple" and "carrot". Another row of entries may have "banana" and "potato".

Sysadmins and security professionals will often use CSV files containing lists of items that they need to parse through.

- For example, a system administrator may use such a file to maintain a list of employee email addresses and usernames.

- A penetration tester might have a list of IP addresses and corresponding domain and subdomain names to use in a test.

We'll look at the CSV file that contains the list of Microsoft Windows applications to be removed.

- Using Powershell, open and display the [demo.csv](./Resources/demo.csv) file on the desktop for the students.

- Run: `type .\demo.csv`

Your output should be similar to:

  ```PowerShell
  appxpkg,name,description
  "Microsoft.ZuneMusic","Zune","Microsoft's Zune Music Player"
  "Microsoft.Music.Preview","Music Preview", "Microsoft's Music Preview"
  "Microsoft.XboxGameCallableUI","Xbox Gaming GUI", "Microsoft's Xbox Overlay"
  ...
  [CSV contents truncated]
  ```

The syntax:

- The first line `appxpkg,name,description` is the header of the CSV file and contains the types of fields for the other lines.

- The rest of the rows, or _records_, contain field entries that should match the number and type of header fields.

- For example, `Microsoft's Zune Music Player` will match up with the `description` header field and `Microsoft.ZuneMusic` will match up with the `appxpkg` header field.

Most common programming and scripting languages have ways to import CSV files and loop through the items one by one. PowerShell has this capability. To loop through this file's items, we have the `foreach` loop.

#### `foreach` Loops

The `foreach` loop in PowerShell is similar to the `for` loop they learned about in the Linux unit, but it is mainly used for looping through files or read-only structured data. 

Some cases that sysadmin and security professionals may use a `foreach` loop instead of a `for` loop:

- A system administrator may have a text or CSV file of usernames they need to loop through to reset each item's password.

- A penetration tester might have a text file with a list of the most commonly used passwords. They may use a `foreach` loop to try out each password with a known user's username.

Reiterate that a `foreach` loop is best when iterating or moving through _items_ in some form of a list. Let's look at how we can use it with CSV files.

#### Demo: Using `Import-Csv` with a `foreach` Loop

We will be using the `Import-Csv` PowerShell cmdlet to source the CSV file `demo.csv` to run with a demo PowerShell script. If the CSV file is constructed with the standard header and record setup, `Import-Csv` will prepare the fields to be called by PowerShell.

Let's look at how that works by creating a PowerShell script that outputs each line of CSV file.

First, we create our script.

- In `Git Bash`, run `nano removebloat.ps1` to start a new PowerShell script.

We are going to use a variable to import our CSV file for our script.

- On the first line, type `$csv = Import-Csv -Path .\demo.csv`.

  - `$csv` is being assigned the `Import-Csv` cmdlet, with parameters indicating where the CSV file is located: 

    `Import-Csv -Path .\demo.csv`

The `Import-CSV` cmdlet is going to load the given file into memory to be readily usable by PowerShell and will assign each line and field as an input to be read. All of the contents of this file will then become available to our script. 

Now, we need a `foreach` loop.

- Start typing a PowerShell `foreach` loop template:

    ```PowerShell
    $csv = Import-Csv -Path .\demo.csv
    foreach () {

    }
    ```

Now set the condition within the parantheses. In this case we're calling the CSV file with a variable and reading each line with another.

- Enter `$line in $csv` in the parentheses `()`.

- This specifies that for every line in the CSV file, `foreach` will execute the following code block with each line's contents.

Now, we need to enter the code that will be executed code on each line.

- Enter `Write-Output $line` in the curly brackets `{}` to get:

  ```PowerShell
  $csv = Import-Csv -Path .\demo.csv
  foreach ($line in $csv) {
      Write-Output $line
  }
  ```

The syntax:

  - Our `foreach` loop will grab the contents of each line in our CSV file and assign it to the `$line` variable.
  
  - For every line that gets assigned to the `$line` variable, the `Write-Output` cmdlet will print the contents of the `$line` variable.

  - This process will repeat, or _loop_, until there are no more lines left to be assigned to the `$line` variable.

When we run this script, we expect it to print out each line in the terminal.

- Type: `CTRL+O` and press enter to save the file in `nano`.

- Switch to the Powershell window.

- Run the script using the command `.\removebloat.ps1`:

  ```PS 
  C:\Users\sysadmin\Desktop> .\removebloat.ps1
  appxpkg                                name                    description
  -------                                ----                    -----------
  Microsoft.ZuneMusic                    Zune                    Microsoft's Zune Music Player
  Microsoft.Music.Preview                Music Preview           Microsoft's Music Preview
  Microsoft.XboxIdentityProvider         Xbox ID Provider        Microsoft's Xbox Live Account Management
  Microsoft.BingTravel                   Bing Travel             Microsoft's Bing Travel
  Microsoft.BingHealthAndFitness         Bing Health and Fitness Microsoft's Bing Health and Fitness
  ```

Confirm that for every line in this CSV file, PowerShell is assigning that line to the variable `$line` and printing it out. After a line is printed out, the loop will continue until all lines have been printed by the `Write-Output` cmdlet.

#### Demo: Importing a CSV File and Looping Through Field Attributes

Our `demo.csv` CSV file has multiple rows containing multiple attributes, such as `apppkg`, `name`, and `description`. But sometimes we want to loop only through the Windows Store application `name`s or `description`s.

This is possible by appending `.name` to the `$line` variable. Your script will return the matching field or attribute entries instead of entire lines. In this case, it returns the application name.

Now what if we want to see just the application name and not the `appxpkg` or `description`:

- Return to the `Git Bash` window and use `nano` to open the script.

- Add `.name` after the `Write-Output $line`:

```powershell
$csv = Import-Csv -Path .\demo.csv
foreach ($line in $csv) {
    Write-Output $line.name
}
```

- Enter `CTRL+O` to save your script file.

- Return to the powershell window and run the script again.

Your output should be similar to:

  ```PowerShell
  PS C:\Users\sysadmin\Desktop> .\removebloat.ps1
  Zune
  Music Preview
  Xbox ID Provider
  Bing Travel
  [etc]
  ```

- Using `Git Bash`, change the `.name` to `.description`, save, and re-run the script in the powershell window.

  ```powershell
  $csv = Import-Csv -Path .\demo.csv
  foreach ($line in $csv) {
      Write-Output $line.description
  }
  ```

- Verify the output:

  ```PowerShell
  PS C:\Users\sysadmin\Desktop> .\removebloat.ps1
  Microsoft's Music Preview
  Microsoft's Xbox Game Bar
  ```

Finally, let's combine the concepts of importing CSV files and creating `foreach` loops with cmdlet pipelines to remove the unnecessary applications on the Windows machine.

- Return to your script in GitBash and change the code block from `Write-Output $line.description` to `Get-AppxPackage -Name $line.appxpkg | Remove-AppxPackage -Verbose`.

- Save with `CTRL+O` but do not run the script yet.

  ```PowerShell
  $csv = Import-Csv -Path .\demo.csv
  foreach ($line in $csv) {
      Get-AppxPackage $line.appxpkg | Remove-AppxPackage -Verbose
  }
  ```

When we execute this script, we should expect PowerShell to notify us of application deployment (or in this case, removal) at the top of the PowerShell Window.

- Run the script in PowerShell to show the verbose output.

We have now written our first PowerShell script that:

- Uses conditionals.
- Imports files.
- Uses cmdlet pipelines to get rid of Windows Store bloat applications. 
 
Let's apply these newly learned skills in the next activity to remove the rest of the Microsoft bloat from their Windows 10 VMs.

### 09. Removing Windows Bloat with Powershell Scripts Activity


- [Activity File: Removing Windows Bloat with Powershell Scripts](Activities/09_Removing_Bloat/Unsolved/Readme.md)
- [Windows Bloat CSV File](Activities/09_Removing_Bloat/microsoftbloat.csv)
- [Syntax Reference and Helpful Hints](./Activities/09_Removing_Bloat/tips.md)

### 10. Review Removing Windows Bloat with PowerShell

  - [Solution file](./Activities/09_Removing_Bloat/Solved/Readme.md)

### 11. Everyone Do: Setting Up for Day 3

In this section, we will prepare for the next lesson by downloading and staging a few scripts.

Next class, we will be setting up and working with an Active Directory server. In order to get it set up we need to:

- Run a script in the **RDP host machine** that will set up Hyper-V so that our two VMs can communicate with each other.

- During the next lesson we will set up the machines so that they have static IP addresses.

- After that, we will run a script inside the **Windows Server VM** that will set up Active Directory for us.

#### Hyper-V PowerShell Commands to Set Up a NAT Switch

The following script will set up a virtual Hyper-V switch, configure it as a NAT network, and then add the two Windows virtual machines to it.

- Send the students the following script: [https://tinyurl.com/HyperV-NAT-Setup](https://tinyurl.com/HyperV-NAT-Setup)

- Execute the following [script](https://tinyurl.com/HyperV-NAT-Setup) in an administrative PowerShell session within the **RDP host lab machine**:

  ```PowerShell
  New-VMSwitch -SwitchName "NATSwitch" -SwitchType Internal
  New-NetIPAddress -IPAddress 192.168.0.1 -PrefixLength 24 -InterfaceAlias "vEthernet (NATSwitch)"
  New-NetNAT -Name "NATNetwork" -InternalIPInterfaceAddressPrefix 192.168.0.0/24
  Get-VM "Windows Server" | Get-VMNetworkAdapter | Connect-VMNetworkAdapter -SwitchName "NATSwitch"
  Get-VM "Windows 10" | Get-VMNetworkAdapter | Connect-VMNetworkAdapter -SwitchName "NATSwitch"
  ```

This will set up Hyper-V network settings that we will utilize in our next lesson.

#### Stage the Active Directory Set Up Script

Next, download the following script into your **Windows Server VM** and NOT the RDP host machine. You do not need to run it now.

If you're unsure how to do this, double-click **Windows Server** in your Hyper-V Manager. Within that VM, open a browser window. Download the following file:

- [https://tinyurl.com/ADDC-Setup](https://tinyurl.com/ADDC-Setup)

  ```PowerShell
  #
  # Windows PowerShell script for AD DS Deployment
  #
  Install-WindowsFeature -name AD-Domain-Services –IncludeManagementTools
  Import-Module ADDSDeployment
  Install-ADDSForest `
  -CreateDnsDelegation:$false `
  -DatabasePath "C:\Windows\NTDS" `
  -DomainMode "WinThreshold" `
  -DomainName "GOODCORP.NET" `
  -DomainNetbiosName "GOODCORP" `
  -ForestMode "WinThreshold" `
  -InstallDns:$true `
  -LogPath "C:\Windows\NTDS" `
  -NoRebootOnCompletion:$false `
  -SysvolPath "C:\Windows\SYSVOL" `
  -Force:$true
  ```

In our next lesson, we will use this script to setup an Active Directory Domain Controller.

Ask students if they have any questions before ending the day.

**IMPORTANT:** Alway remember  to turn off the VMs and the host machine at the end of class	

---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

## Solution Guide: Move and Create Directories

In this activity, you were tasked with setting up multiple directories for the Windows 10 workstation.

Completing this activity required the following steps:

- Move the `contracts` directory to `C:\`.

- Create a `Logs` and `Scripts` directory in `C:\`.

- Rename the `contracts` directory to `Contracts`.

---

First, make sure we're working out of Alex's desktop directory:

- Run `Set-Location C:\Users\Alex\Desktop`

Next, move to `C:\`.

- Run `Move-Item contracts C:\`

Verify `contracts` is no longer here.

- Run `Get-ChildItem C:\`

Now, we want to work out of `C:\`.

- Run `Set-Location C:\`

Now let's make our `Logs` and `Scripts` directories.

- Type `New-Item -Path "C:\" -Name "Logs" -ItemType "Directory"`, but don't run it yet. 

We can actually shorten this command a little and have it create both directories.

- Enter `CTRL+C` to clear the line.

- Run `New-Item "Logs", "Scripts" -ItemType "Directory" -Force`

    - This command will create both directories in the current directory.

    - The `-Force` parameter will ignore any errors if the directories already exist.

- Run `Get-ChildItem` to show `Contracts`, `Logs`, and `Scripts` in `C:\`. We'll now have the following directories:

  - `C:\Logs`
  - `C:\Contracts`
  - `C:\Scripts`

**Bonus**

Use `Rename-Item` to capitalize the `contracts` directory. 

- While using `Rename-Item contracts Contracts` seems like the correct option (if you recall `mv` in `bash`), the command actually errors out. 

Instead, we can use `Rename-Item` twice to change the directory name:

- `Rename-Item contracts1`

- `Rename-Item Contracts`

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

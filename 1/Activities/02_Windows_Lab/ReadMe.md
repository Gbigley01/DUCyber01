## Instructions for Launching Your Windows Lab

We'll begin class by setting up our Azure Lab Environment. Follow these instructions alongside your instructor. 


#### Log into Azure Labs

1. Use RDP to log into their Azure lab. 

    - Credentials for the Azure RDP Host:
    - Username: `azadmin`
    - Password: `p4ssw0rd*`

2. Launch the **Hyper-V Manager**:

    - Click the bottom-left Windows icon (the Start Menu button) in the Azure RDP host.
    - Type "Hyper-V" in the search to show the **Hyper-V Manager** application.
    - Click on **Hyper-V Manager** to launch the Azure virtualization lab.

This **Hyper-V Manager** is equivalent to the **VirtualBox Manager**. It manages and launches virtual machines within our Azure environment.

#### Increase Hyper-V Virtual Machine Resource Allocations

Before we start today's lessons, we need to ensure that we have proper resource allocation for our virtual machines. In order to do so, we're going to increase the available RAM and CPU for our Windows 10 virtual machine.

1. In the **Hyper-V Manager**, on the left pane, click  the tabulated entry beneath "Hyper-V Manager". It will look like a combination of letters of numbers (e.g.: `ML-REFVM-370502`).

    - The middle pane will change to show  a list of virtual machines available within our Azure lab.

2. Ensure your virtual machine is shut off by right-clicking the **Windows 10** virtual machine and selecting `Turn Off...`

3. Right-click the **Windows 10** virtual machine and go to **Settings**.

  - Under `Memory`, change the `RAM` to:`8192` MB.

  - Under `CPU`, change the `Number of virtual processors` to `2`

  - Select `Apply`, then `OK` at the bottom to apply these changes.

This will give our virtual machine additional resources from our RDP host machine to run on, improving its performance. Since we are using nested virtualization, it's important to allocate enough resources to maximize virtual machine performance.

#### Launch the Windows 10 Virtual Machine

All of your activities will be done within these virtual machines.

-  Double-click the **Windows 10 virtual machine** to launch it. 

    - Credentials for the Windows 10 VM for today's activities:
    - Username: `sysadmin`
    - Password: `cybersecurity`

**Note**: If you encounters save state issues, run the PowerShell command: `Get-VMSnapshot | Remove-VMSavedState` **within the RDP lab** and attempt to re-launch the Windows 10 VM. See your instructional staff for additional information.


#### Startup Application and Installer Maintenance

The nested Windows 10 machine has a lot of clutter installed on it (which will be addressed later in the day). In order to get started with it this clutter, we will need to close these start-up application windows.

- For any application or installer window that pops up after booting the machine, click the top-right `X` in each Window to close it. If it asks you if you are sure, confirm.

We'll look at how to disable these applications in a few minutes.

#### Extend the Windows Virtual Machine Evaluation License

This Windows 10 virtual machine will require an extension of the evaluation license so that the Windows 10 does not shut down abruptly.

Within the **Windows 10 Virtual Machine**:

1. Select the Windows icon at the bottom-left and begin typing `CMD`.

2. When the `Command Prompt` application shows up, right-click and select `Run as administrator`.

3. Within the administrator CMD terminal window inside of the Windows 10 VM, run the following command:  
    -  `slmgr.vbs /rearm`

4. The virtual machine can then be rebooted by clicking the Windows icon, selecting the power icon above it, then selecting `Restart`.

This will add an additional 90 days to our virtual machine evaluation license and prevent unwanted shut downs that occur from expired licenses.

**Note**: Repeat the same steps within the **Windows Server Virtual Machine** if there is less than 30 days on the evaluation license.


---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.   
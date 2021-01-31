# Virtual Machine Download

You will use a local virtual machine for several units of our program, **beginning with Terminal Week and through the Linux weeks.**

You should have already downloaded and installed Virtual Box as part of pre-work. If you haven't, that will be the first step. 

Following that you will install a tool called Vagrant, which you'll use to download the VM. 

The steps below can feel intimidating, especially if you are new to the command line. By Week 2, Day 3, you only need to make sure that you have the correct versions of Virtual Box and Vagrant installed. Additionally, Windows users should make sure that they have GitBash installed. 

In Week 2, Day 3, your instructor will demonstrate how to download the virtual machine. If you run into any issues, please use office hours afterwards to make sure that you have everything set up prior to Week 3, Day 1. 

## Downloading & Running the Machine
### Windows and Mac Users

Windows users will need to install Git Bash. Please go here to download Gitbash if you haven't already done so in pre-work: https://gitforwindows.org/

Mac users will use Terminal. You can open Terminal by clicking on your Finder (the magnifying glass) at the top right corner of your computer. Type in Terminal and press enter in order to open it. 

### Virtual Box

Download and install `Virtual Box`, : https://www.virtualbox.org/wiki/Download_Old_Builds_6_0
- Note that Vagrant requires Virtual Box version 6.0. It **will not work** with version 6.1 — please be sure to download from the link above.
- In pre-work you may have downloaded a more recent version. If this is the case, please make sure to download Virtual Box **version 6.0**

### Vagrant

Download and install the latest version of `Vagrant`, currently `2.2.7`: https://www.vagrantup.com/downloads.html

Select the appropriate  installer for your operating system:

The installer should save to your `~/Downloads` directory. 

Open this folder, then double-click the installer. 

This will install Vagrant on your system.


### Downloading the Virtual Machine 

**Note:** Your instructor will demonstrate this during Week 2, Day 3. If you run into any issues, please use office hours after that class to ensure that you are properly set up. 

After Vagrant is installed, download and run the two files, also located in the zipped directory.  Make sure that you see these files after you unzipped the directory. 

- Download the script, called `vagrant-linux.sh` 
- Download the `Vagrantfile`

Open **Git Bash** (Windows) or **Terminal** (Mac).

* **Note:** Windows users should make sure they open Git Bash as an administrator. This usually happens by default, actually, but to be sure:

- Search for **Git Bash** in the Windows search bar (bottom-left)
- Right-click **Git Bash**, then click **Run as administrator**

First, move to the directory where you downloaded the script and Vagrantfile. Type in and enter the following:  `cd ~/Downloads` 

If you are using **Windows**, type in and enter the following: `bash vagrant-linux.sh --create`

If your are using **Mac**, type in and enter the following: `sudo bash vagrant-linux.sh --create`

This will download and start the VM we will be using henceforth. It will automatically appear in a GUI after it is downloaded and started. 

### **Accessing Your Virtual Machine**

**Note:** You must have your machine downloaded in order to access it. Your instructor will demonstrate this during Week 2, Day 3, and once it has been downloaded, you can follow the steps below to access the virtual machine. 

You will learn how to access your virtual machine via the command line in the upcoming units. 

For now, you can open VirtualBox. You will see the machine you downloaded in the left hand pane. 

* Click the Linux machine 
* Then, click the Start icon in the top menu. 
* Allow 3-5 minutes for the machine to come up. 

Enter in the log-in credentials, when prompted:

* Username: `sysadmin`
* Password: `cybersecurity`

When you are done using the machine, you can close window on the GUI (graphical user interface). This will give you options as to how to shut down. Make sure to select the first option **"Save the Machine State"**


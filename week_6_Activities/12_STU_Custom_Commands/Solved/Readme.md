## Solution Guide: Custom Commands

This activity turned our script into a custom command and added a script directory to the `$PATH` so that command can be called directly.

To complete this activity, we needed to do the following:

- Ensure that the script from the last activity runs as expected.
- Add the new commands listed in the instructions.
- Save the script in a ~/scripts directory.
- Add that ~/scripts directory to the `$PATH` variable.
- Run your script by calling it's name only.


### Solutions

Inside your script:

Add the command for creating a `~/research` directory to your script.

-  `mkdir ~/research 2> /dev/null`
       
    ```bash
    # Create directory for output
    mkdir ~/research 2> /dev/null
    ```

Add the command for finding `SUID` files to your script.

- `echo -e "\nSUID Files:" >> ~/research/sys_info.txt`

- `find / -type f -perm /4000 >> ~/research/sys_info.txt`

    These next two commands are exactly the same as they were in first two exercises. The only thing we are adding is an `echo` command that will give each command's output a heading.

Add the command for finding the top 10 processes to your script.

- `echo -e "\nTop 10 Processes" >> ~/research/sys_info.txt`
- `ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >> ~/research/sys_info.txt`

Modify each command of the script so that it writes all output to a file called `~/research/sys_info.txt`

- Add `>> ~/research/sys_info.txt` to each line of your script.

At this point, our script should look like:

```bash
#!/bin/bash

mkdir ~/research 2> /dev/null

echo "A Quick System Audit Script" > ~/research/sys_info.txt
date >> ~/research/sys_info.txt
echo "" >> ~/research/sys_info.txt
echo "Machine Type Info:" >> ~/research/sys_info.txt
echo $MACHTYPE >> ~/research/sys_info.txt
echo -e "Uname info: $(uname -a) \n" >> ~/research/sys_info.txt
echo -e "IP Info: $(ip addr | grep inet | tail -2 | head -1) \n" >> ~/research/sys_info.txt
echo -e "Hostname: $(hostname -s) \n" >> ~/research/sys_info.txt
echo "DNS Servers: " >> ~/research/sys_info.txt
cat /etc/resolv.conf >> ~/research/sys_info.txt
echo -e "\nMemory Info:" >> ~/research/sys_info.txt
free >> ~/research/sys_info.txt
echo -e "\nCPU Info:" >> ~/research/sys_info.txt
lscpu | grep CPU >> ~/research/sys_info.txt
echo -e "\nDisk Usage:" >> ~/research/sys_info.txt
df -H | head -2 >> ~/research/sys_info.txt
echo -e "\nWho is logged in: \n $(who -a) \n" >> ~/research/sys_info.txt
echo -e "\nSUID Files:" >> ~/research/sys_info.txt
sudo find / -type f -perm /4000 >> ~/research/sys_info.txt
echo -e "\nTop 10 Processes" >> ~/research/sys_info.txt
ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head >> ~/research/sys_info.txt
```


In your command line environment:

Manually create a `~/scripts` directory and save your script there. (This is a great opportunity to chain two commands together to complete a task.)

- `mkdir ~/scripts && cp sys_info.sh ~/scripts`

Add your `~/scripts` directory to your `$PATH`

- `echo "export PATH=$PATH:~/scripts" >> ~/.bashrc`

    - `echo` is printing everything that comes next.
    - `"export` allows the variable to be used across different shells.
    - `PATH=` is the assignment of our variable.
    - `$PATH` is calling the variable as it is now. So, the first part of our new variable for `PATH` will be a copy of the old variable `PATH`.
    - `:` is the delimiter used within the `PATH` variable in between each directory path.
    - `~/scripts"` is the directory we are adding and closes out the `echo` command.
    - `>> ~/.bashrc` appends the output from `echo` to the bottom of the `bashrc` file.

Run `tail -1 bashrc`.

- Your output should be similar to:

    ```bash
    $ tail -1 ~/.bashrc                         
    PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/snap/bin:/usr/local/lib/python3.7/site-packages/:/home/user/.local/bin:/home/user/scripts
    ```

Reload your bashrc file.

-  `source ~/.bashrc`
    
    Note: we only need to type the name of the script file in order to run it. 

Run your script:

-  `sys_info.sh`

    Futhermore: we can remove the `.sh` file extension to make this more like a command.
    
We now have a command `sin` that runs all the commands in your script and saves them to an output file.

- Run `mv ~/scripts/sys_info.sh ~/scripts/sin`

Open `~/research/sys_info.txt` and verify it has the desired output.

- Run `less ~/research/sys_info.txt`

The contents of our script should look similar to this:


```bash
#!/bin/bash

mkdir ~/research 2> /dev/null

echo "A Quick System Audit Script" > ~/research/sys_info.txt
date >> ~/research/sys_info.txt
echo "" >> ~/research/sys_info.txt
echo "Machine Type Info:" >> ~/research/sys_info.txt
echo $MACHTYPE >> ~/research/sys_info.txt
echo -e "Uname info: $(uname -a) \n" >> ~/research/sys_info.txt
echo -e "IP Info: $(ip addr | head -9 | tail -1) \n" >> ~/research/sys_info.txt
echo -e "Hostname: $(hostname -s) \n" >> ~/research/sys_info.txt
echo "DNS Servers: " >> ~/research/sys_info.txt
cat /etc/resolv.conf >> ~/research/sys_info.txt
echo -e "\nMemory Info:" >> ~/research/sys_info.txt
free >> ~/research/sys_info.txt
echo -e "\nCPU Info:" >> ~/research/sys_info.txt
lscpu | grep CPU >> ~/research/sys_info.txt
echo -e "\nDisk Usage:" >> ~/research/sys_info.txt
df -H | head -2 >> ~/research/sys_info.txt
echo -e "\nWho is logged in: \n $(who -a) \n" >> ~/research/sys_info.txt
echo -e "\nSUID Files:" >> ~/research/sys_info.txt
sudo find / -type f -perm /4000 >> ~/research/sys_info.txt
echo -e "\nTop 10 Processes" >> ~/research/sys_info.txt
ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head >> ~/research/sys_info.txt
```

The contents of `sys_info.txt` file should look similar to this:

```bash
A Quick System Audit Script
Thu Aug 22 2019

Machine Type Info:
x86_64-pc-linux-gnu
Uname info: Linux work 4.14.119-2.pvops.qubes.x86_64 #1 SMP Wed May 15 06:43:11 UTC 2019 x86_64 GNU/Linux

IP Info:     inet 10.137.0.15/32 brd 10.255.255.255 scope global eth0

Hostname: work

DNS Servers:
nameserver 10.139.1.1
nameserver 10.139.1.2

Memory Info:
              total        used        free      shared  buff/cache   available
Mem:        7956892     3000244     2829044      288936     2127604     4639724
Swap:       1048572           0     1048572

CPU Info:
CPU op-mode(s):        32-bit, 64-bit
CPU(s):                4
On-line CPU(s) list:   0-3
CPU family:            6
Model name:            Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
CPU MHz:               2112.182
NUMA node0 CPU(s):     0-3

Disk Usage:
Filesystem      Size  Used Avail Use% Mounted on
/dev/xvda3       11G  7.2G  2.7G  74% /

Who is logged in:
            system boot  2019-08-22 15:12
           run-level 3  2019-08-22 15:12
LOGIN      hvc0         2019-08-22 15:12               626 id=hvc0
LOGIN      tty1         2019-08-22 15:12               623 id=tty1


SUID Files:
/usr/lib/openssh/ssh-keysign
/usr/lib/eject/dmcrypt-get-device
/usr/lib/dbus-1.0/dbus-daemon-launch-helper
/usr/lib/qubes/qfile-unpacker
/usr/lib/xorg/Xorg.wrap
/usr/lib/policykit-1/polkit-agent-helper-1
/usr/sbin/pppd
/usr/sbin/exim4
/usr/bin/newgrp
/usr/bin/chsh
/usr/bin/pkexec
/usr/bin/gpasswd
/usr/bin/chfn
/usr/bin/passwd
/usr/bin/sudo
/sbin/pam-tmpdir-helper
/opt/brave.com/brave/brave-sandbox
/bin/ntfs-3g
/bin/su
/bin/umount
/bin/fusermount
/bin/mount
/bin/ping

Top 10 Processes
USER PID %CPU %MEM COMMAND
user 4997 0.3 4.6 /usr/lib/slack/slack
user 21470 0.5 4.5 /usr/lib/slack/slack
user 2618 0.8 3.8 /usr/share/atom/atom
user 8706 0.5 3.0 /opt/brave.com/brave/brave
user 1019 0.6 2.7 /opt/brave.com/brave/brave
user 2575 0.9 2.5 /usr/share/atom/atom
user 2909 0.7 2.5 /opt/zoom/zoom
user 8718 0.1 2.4 /opt/brave.com/brave/brave
user 3212 0.4 1.9 /usr/lib/slack/slack
```

---

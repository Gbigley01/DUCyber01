## Solution Guide: Lists and Loops

In the previous activity we added variables to our script.  We also added conditional flow control using `if` statements.

Next, you will use loops to automate repetitive tasks in your script.

Loops facilitate code reuse, by allowing commands to be run many times without actually typing them repeatedly.

To complete this activity, you will create several `for` loops that satisfy given requirements. If you get to the bonus, you can incorporate a `for` loop into your script.

### Instructions

#### Create your script file.
1. Create a new file named `for_loops.sh` and open it in your text editor.
**Solution**: `nano for_loops.sh`

2. Add the required `boiler plate` line at the top so your computer knows it's a bash script.
**Solution**: `#!/bin/bash`

#### Create your variables
1. Create a variable that holds a list of numbers from `0-9`
**Solution**: `nums=$(echo {0..9})`

2. Create another variable that holds a list of 5 of your favorite U.S. states (e.g. Nebraska, Hawaii, California, etc.)
**Solution**: `states=('Nebraska' 'California' 'Texas' 'Hawaii' 'Washington')`

3. Create another variable that holds the output of the command `ls`
**Solution**: `ls_out=$(ls)`

#### Create your `for` loops
1. Create a `for` loop that prints out only the numbers 3, 5 and 7 from your list of numbers.
**Solution**:
```bash
for num in ${nums[@]}
do
  if [ $num = 3 ] || [ $num = 5 ] || [ $num = 7 ]
  then
    echo $num
  fi 
done
```


2. Create a `for` loop that checks for the state 'Hawaii' in your list of states. If the 'Hawaii' is there, print "Hawaii is the best!". If is not there, print "I'm not fond of Hawaii".

**Solution**:
```bash
for state in ${states[@]}
do

  if [ $state == 'Hawaii' ];
  then
    echo "Hawaii is the best!"
  else
    echo "I'm not a fan of Hawaii."
  fi
done
```

3. Create a `for` loop that prints out each item in your variable that holds the output of the `ls` command.
**Solution**:
```bash
for x in ${ls_out[@]}
do
  echo $x
done
```

#### Bonus
1. During the last exercise, you created a variable that holds the command `find / -type f -perm /4000 2> /dev/null` and then you used `echo` to print out your variable later in the script.

You may have noticed that this produces an output that is a bit jumbled together:
```bash
SUID Files:
/usr/lib/openssh/ssh-keysign /usr/lib/eject/dmcrypt-get-device /usr/lib/dbus-1.0/dbus-daemon-launch-helper /usr/lib/qubes/qfile-unpacker /usr/lib/xorg/Xorg.wrap /usr/lib/policykit-1/polkit-agent-helper-1 /usr/sbin/pppd /usr/sbin/exim4 /usr/bin/newgrp /usr/bin/chsh /usr/bin/pkexec /usr/bin/gpasswd /usr/bin/chfn /usr/bin/passwd /usr/bin/sudo /sbin/pam-tmpdir-helper /opt/brave.com/brave/brave-sandbox /bin/ntfs-3g /bin/su /bin/umount /bin/fusermount /bin/mount /bin/ping
```

##### Challenge
Instead of using `echo` to print out this variable, use a `for` loop to print out each file on it's own line.
**Solution**:
```bash
suids=$(find / -type f -perm /4000 2> /dev/null)

for suid in ${suids[@]}
do
  echo $suid
done
```

### Example Contents of for_loops.sh
```bash
#!/bin/bash

# Create Variables
nums=$(seq 0 9)
states=('Nebraska' 'California' 'Texas' 'Hawaii' 'Washington' 'New York')
ls_out=$(ls)
suids=$(find / -type f -perm /4000 2> /dev/null)

# Create For Loops
# Create a loop that prints 3, 5, or 7
for num in ${nums[@]}
do
  if [ $num = 3 ] || [ $num = 5 ] || [ $num = 7 ]
  then
    echo $num
  fi 
done


# Create a loop that looks for 'Hawaii'
for state in ${states[@]};
do
  if [ $state == 'Hawaii' ];

  then
    echo "Hawaii is the best!"
  else
    echo "I'm not a fan of Hawaii."
  fi
done

# Create a `for` loop that prints out each item in your variable that holds the output of the `ls` command.
for x in ${ls_out[@]}
do
  echo $x
done

# Bonus
# Create a for loop to print out suids on one line for each entry
for suid in ${suids[@]}
do
  echo $suid
done

```

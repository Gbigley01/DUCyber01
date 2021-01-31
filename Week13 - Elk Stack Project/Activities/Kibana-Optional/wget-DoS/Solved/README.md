#### Web Request Dos Optional Activity Solutions

#### Instructions

The Metrics section for a single WebVM will show `Load` and `Network Traffic` data. 

We can generate abnormal data to view here by creating a DoS web attack. The command line program `wget` can do this easily.
**Solutions:**

`wget` will download a file from any web server. Use the `man pages` for more info on `wget`.

- Login to your Jump-Box

- Run `wget ip.of.web.vm`

```bash
sysadmin@Jump-Box-Provisioner:~$ wget 10.0.0.5
--2020-05-08 15:44:00--  http://10.0.0.5/
Connecting to 10.0.0.5:80... connected.
HTTP request sent, awaiting response... 302 Found
Location: login.php [following]
--2020-05-08 15:44:00--  http://10.0.0.5/login.php
Reusing existing connection to 10.0.0.5:80.
HTTP request sent, awaiting response... 200 OK
Length: 1523 (1.5K) [text/html]
Saving to: ‘index.html’

index.html            100%[=======================>]   1.49K  --.-KB/s    in 0s      

2020-05-08 15:44:00 (179 MB/s) - ‘index.html’ saved [1523/1523]
```

Run `ls` to view the file you downloaded from your web vm to your jump-box:

```bash
sysadmin@Jump-Box-Provisioner:~$ ls
index.html
```

**Your task:**

- Run the `wget` command in a loop to generate a ton of web requests.
	- You can use a bash `for` or `while` loop, directly on the command line, just as you did with the `SSH` command.

**for loop:**

```bash
sysadmin@Jump-Box-Provisioner:~$ for i in {1..1000}; do wget 10.0.0.5; done
```
**Important:** This loop will create 1000 web requests on the 10.0.0.5 server and 1000 downloaded files on your jump-box.

Syntax Breakdown:
- `for` begins the for loop.
- `i in` creats a varible named `i` that will hold each number `in` our list.
- `{1..1000}` creates a list of 1000 numbers, each of which will be given to our `i` variable.
- `;` seperates the portions of our `for` loop when it's written on one line.
- `do` is what each iteration of the loop will do.
- `wget 10.0.0.5` is the comand run by `do`.
- `;` seperates the portions of our `for` loop when it's written on one line.
- `done` closes the `for` loop.

**while loop:**

```bash
sysadmin@Jump-Box-Provisioner:~$ while true; do wget 10.0.0.5; done
```
**Important:** This loop will continue to run until you stop it using `CTRL + C` and will create thousands of web requests on the 10.0.0.5 server as well as files on your jump-box.

Syntax Breakdown:
- `while` begins the while loop.
- `true` will always be equal to `true` so this loop will _never_ stop, unless you force quit it.
- `;` seperates the portions of our `whle` loop when it's written on one line.
- `do` is what each iteration of the loop will do.
- `wget 10.0.0.5` is the comand run by `do`.
- `;` seperates the portions of our `for` loop when it's written on one line.
- `done` closes the `for` loop.

- Open the `Metrics` page for the web machine you attacked and answer the following questions:
	
	- Which of the VM Metrics was affected the most from this traffic?

	**Answer:** The Load and Networking Metrics were hit:

	![](../../../../Images/metrics-kibana/load-net.png)

#### Bonus 1

Notice that your `wget` loop creates a lot of duplicate files on your jump-box.

1. Write a command to delete _all_ of these files at once.

```bash
sysadmin@Jump-Box-Provisioner:~$ rm *
```

2. Find a way to run the `wget` command without generating these extra files.
- Look up the flag options for `wget` and find the flag that lets you choose a location to save the file it downloads. 

**Answer:** From the man pages:
```bash
	-O file
	--output-document=file
			The documents will not be written to the appropriate files, but all will
			be concatenated together and written to file.  If - is used as file,
			documents will be printed to standard output, disabling link conversion.
			(Use ./- to print to a file literally named -.)
```
- Save that file to the linux directory known as the 'void' or the directory that doesn't save anything.

**Answer:** The directory known as the 'void' that doesn't save anything is `/dev/null`

Full command: `while true; do wget 10.0.0.5 -O /dev/null; done`


#### Bonus 2

Write a nested loop that sends your `wget` command to all 3 of your web VM's over and over.

```bash
sysadmin@Jump-Box-Provisioner:~$ while true; do for i in {5..7}; do wget -O /dev/null 10.0.0.$i; done; done
```
**Important:** This loop will continue to run until you stop it using `CTRL + C` and will create thousands of web requests.

Syntax Breakdown:
- `while` begins our first `while` loop.
- `true` will always be equal to `true` so this loop will _never_ stop, unless you force quit it.
- `;` seperates the portions of our first `while` loop when it's written on one line.
- `for` begins the second for loop.
- `i in` creats a varible named `i` that will hold each number `in` our list.
- `{5..7}` creates a list of numbers, (5, 6 and 7) each of which will be given to our `i` variable.
- `;` seperates the portions of our `for` loop when it's written on one line.
- `do` is what each iteration of the loop will do.
- `wget 10.0.0.$i` is the comand run by `do`. Notice that here we are passing in our `$i` variable so the `wget` command will be run on each server.
- `;` seperates the portions of our `for` loop when it's written on one line.
- `done` closes the `for` loop.
- `;` seperates the portions of our first `while` loop when it's written on one line.
- `done` closes the `while` loop.

OR

```bash
sysadmin@Jump-Box-Provisioner:~$ while true; do for i in 5 8 12; do wget -O /dev/null 10.0.0.$i; done; done
```

**Important:** This loop will continue to run until you stop it using `CTRL + C` and will create thousands of web requests.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved. 
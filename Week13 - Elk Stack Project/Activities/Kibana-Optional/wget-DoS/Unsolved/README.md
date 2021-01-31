#### Web Request Dos Optional Activity
Welcome! 

This is an optional activity for the Project week. It should only be completed after _all_ other aspects of the project are complete.

It is not required to complete the project and can be completely ignored if you wish.

#### Scenario

You are a cloud architect that has been tasked with setting up an ELK server to gather logs for the Incident Response team to use for training.

Before you hand over the server to the IR team, your senior architect has asked that you verify the ELK server is working as expected and pulling both logs and metrics from the pen-testing web servers.

Your task: Generate a high amount of web requests to your pen-testing servers and make sure that Kibana is picking them up.

---

#### Instructions

The Metrics section for a single WebVM will show `Load` and `Network Traffic` data. 

We can generate abnormal data to view here by creating a DoS web attack. The command line program `wget` can do this easily.

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

- Open the `Metrics` page for the web machine you attacked and answer the following questions:
	
	- Which of the VM Metrics was affected the most from this traffic?

#### Bonus 1

Notice that your `wget` loop creates a lot of duplicate files on your jump-box.

1. Write a command to delete _all_ of these files at once.

2. Find a way to run the `wget` command without generating these extra files.
- Look up the flag options for `wget` and find the flag that lets you choose a location to save the file it downloads. 
- Save that file to the linux directory known as the 'void' or the directory that doesn't save anything.

#### Bonus 2

Write a nested loop that sends your `wget` command to all 3 of your web VM's over and over.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved. 
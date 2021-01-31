#### SSH Barrage Optional Activity
Welcome! 

This is an optional activity for the Project week. It should only be completed after _all_ other aspects of the project are complete.

It is not required to complete the project and can be completely ignored if you wish.

#### Scenario

You are a cloud architect that has been tasked with setting up an ELK server to gather logs for the Incident Response team to use for training.

Before you hand over the server to the IR team, your senior architect has asked that you verify the ELK server is working as expected and pulling both logs and metrics from the pen-testing web servers.

Your task: Generate a high amount of failed SSH login attempts and verify that Kibana is picking up this activity.

---

#### Instructions

One way we can generate some logs of interest is to create some failed SSH logins on our servers.

The only environment that holds our SSH keys is our Ansible container. Attempting to create an SSH connection from _any other_ environment will trigger a log entry.

We can also create a log entry by attempting to login with the wrong username.

Note also that a successful SSH login _also_ creates a log entry, but here we will focus on failed logins.

We can easily do this by trying to SSH to a web machine from our Jump-Box directly without using the Ansible container. 

Start by logging into your jump-box. 

Run: `ssh username@ip.of.web.vm`

You should receive an error:

```bash
sysadmin@Jump-Box-Provisioner:~$ ssh sysadmin@10.0.0.5
sysadmin@10.0.0.5: Permission denied (publickey).
```

This error was also logged and sent to Kibana. 

**Your Task:**

- Run the failed SSH command in a loop to generate a ton of failed login log entries.
	- You can use a bash `for` or `while` loop, directly on the command line, to run the ssh command over and over.

- Search through the logs in Kibana to locate your generated failed login attempts.

#### Bonus

- Create a nested loop that generates SSH login attempts across all 3 of your VM's.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved. 
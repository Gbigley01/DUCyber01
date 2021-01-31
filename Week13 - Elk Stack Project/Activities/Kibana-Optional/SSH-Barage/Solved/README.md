#### SSH Barrage Optional Activity Solutions

#### Instructions

One way we can generate some logs of interest is to create some failed SSH logins on our servers.

The only environment that holds our SSH keys is our Ansible container. Attempting to create an SSH connection from _any other_ environment will trigger a log entry.

We can also create a log entry by attempting to login with the wrong username.

Note also that a successful SSH login _also_ creates a log entry, but here we will focus on failed logins.

We can easily do this by trying to SSH to a web machine from our Jump-Box directly without using the Ansible container. 
**Solutions:**

Start by logging into your jump-box. 

Run: `ssh username@ip.of.web.vm`

You should receive an error:

```bash
sysadmin@Jump-Box-Provisioner:~$ ssh sysadmin@10.0.0.5
sysadmin@10.0.0.5: Permission denied (publickey).
```

This error was also logged and sent to Kibana. 

**Your Task:**
- Run the failed SSH command in a loop to generate a large number of failed login entries in the system logs. You can use a bash `for` or `while` loop on the command line to run the SSH command repeatedly.

#### Solution with `for` Loop
```bash
# Creates 1000 login attempts on the 10.0.0.5 server.
sysadmin@Jump-Box-Provisioner:~$ for i in {1..1000}; do ssh sysadmin@10.0.0.5; done
```

Syntax Breakdown:
- `for` begins the for loop.
- `i in` creats a varible named `i` that will hold each number `in` our list.
- `{1..1000}` creates a list of 1000 numbers, each of which will be given to our `i` variable.
- `;` seperates the portions of our `for` loop when it's written on one line.
- `do` is what each iteration of the loop will do.
- `ssh sysadmin@10.0.0.5` is the comand run by `do`.
- `;` seperates the portions of our `for` loop when it's written on one line.
- `done` closes the `for` loop.

#### Solution with `while` Loop
```bash
# IMPORTANT: This loop will continue to run until you stop it using `CTRL + C` 
# It will create thousands of login attempts on the 10.0.0.5 server.
sysadmin@Jump-Box-Provisioner:~$ while true; do ssh sysadmin@10.0.0.5; done
```

Syntax Breakdown:
- `while` begins the while loop.
- `true` will always be equal to `true` so this loop will _never_ stop, unless you force quit it.
- `;` seperates the portions of our `whle` loop when it's written on one line.
- `do` is what each iteration of the loop will do.
- `ssh sysadmin@10.0.0.5` is the comand run by `do`.
- `;` seperates the portions of our `for` loop when it's written on one line.
- `done` closes the `for` loop.

- Search through the logs in Kibana to locate your generated failed login attempts.

You should find a section of logs that look like this:

![](../../../../Images/metrics-kibana/Log-Auth.png)

#### Bonus

- Create a nested loop that generates SSH login attempts across all 3 of your VM's.

```bash
sysadmin@Jump-Box-Provisioner:~$ while true; do for i in {5..7}; do ssh sysadmin@10.0.0.$i; done; done
```
**Important:** This loop will continue to run until you stop it using `CTRL + C` and will create thousands of login attempts.

Syntax Breakdown:
- `while` begins our first `while` loop.
- `true` will always be equal to `true` so this loop will _never_ stop, unless you force quit it.
- `;` seperates the portions of our first `while` loop when it's written on one line.
- `for` begins the second for loop.
- `i in` creats a varible named `i` that will hold each number `in` our list.
- `{5..7}` creates a list of numbers, (5, 6 and 7) each of which will be given to our `i` variable.
- `;` seperates the portions of our `for` loop when it's written on one line.
- `do` is what each iteration of the loop will do.
- `ssh sysadmin@10.0.0.$i` is the comand run by `do`. Notice that here we are passing in our `$i` variable so the `wget` command will be run on each server.
- `;` seperates the portions of our `for` loop when it's written on one line.
- `done` closes the `for` loop.
- `;` seperates the portions of our first `while` loop when it's written on one line.
- `done` closes the `while` loop.

Note that the brace expansion (`{5..7}`) will only work if the IP addresses of your servers end in `5`, `6`, or `7`. If their IP numbers are not in sequence, we can list them explicitly, instead:

```bash
# Note `for i in 5 8 12`
sysadmin@Jump-Box-Provisioner:~$ while true; do for i in 5 8 12; do ssh sysadmin@10.0.0.$i; done; done
```

**Please note** that this loop will continue to run until you stop it using `CTRL + C` and will create thousands of login attempts.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved. 
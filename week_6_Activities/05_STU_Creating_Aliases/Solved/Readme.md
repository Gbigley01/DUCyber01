## Solution Guide: Creating Aliases

In this exercise, you created custom commands using aliases and the `~/.bashrc` file.

- You had to create the following aliases:

    - A custom `ls` command.
    - Custom commands to change directories into `Documents`, `Downloads`, and the `/etc` directory.
    - A custom command to easily edit the `~/.bashrc` file.
    - Custom commands for each of the compound commands you created in the previous activity.

- You also had to reload the `.bashrc` file so the commands took effect.

---

Log into the lab environment with the username `sysadmin` and password `cybersecurity`.

You can either add commands directly inside `~/.bashrc` using `nano`, or you can use output redirection to append them to the `~/.bashrc` file.

**Important**: Remember, you must use `>>` and not `>`, or else you will overwrite the entire file. It's recommended to make a backup of the `~/.bashrc` file before changing it.

Start by creating a backup copy of your `~/.bashrc` file.

- Run `cp ~/.bashrc ~/.bashrc.bak`

Create an alias in your `~/.bashrc` file for `ls -a`.
- Type `echo "alias lsa='ls -a'" >> ~/.bashrc`

    - `alias` declares that what comes next is an alias.
    - `lsa=` is the name we gave to our new command. We can use anything we want, but we want to be careful not to use a command that already exists.

- Note that we have to use a mixture of `""` and `''` here to get this to work correctly.
    - `'ls -a'` is the command we are creating the alias for.
    - The echo command is wrapped in `""` and the alias is wrapped in `''`.

 - `alias lsa='ls -a'` is the only line we need to add to our `~/.bashrc file`. If we wanted to add this directly to the `bashrc` file, we could use `echo` and redirection to do it in one line.

- Run `echo "alias lsa='ls -a'" >> ~/.bashrc`
    - We could chain it together with `&& source ~/.bashrc` to automatically reload the file and enable the new alias.
        - Example: `echo "alias lsa='ls -a'" >> ~/.bashrc && source ~/.bashrc`

---

Create an alias in your `~/.bashrc` file for `cd ~/Documents`, `cd ~/Downloads`, `cd /etc`.

- `~/Documents`:
    - Run `echo "alias docs='cd ~/Documents'" >> ~/.bashrc`

- `~/Downloads`:
    - Run `echo "alias dwn='cd ~/Downloads'" >> ~/.bashrc`

- `~/etc`:
    - Run `echo "alias etc='cd /etc'" >> ~/.bashrc`


We use the command `alias docs='cd ~/Documents'` for each directory, only changing the name of the alias and the directory for each.

- This is the only line needed for the `~/.bashrc` file.

Take a moment to see what's happening to the `~/.bashrc` file.

- Run `tail -4 ~/.bashrc`

    You should get output similar to:

    ```bash
    alias lsa='ls -a'
    alias docs='cd ~/Documents'
    alias dwn='cd ~/Downloads'
    alias etc='cd /etc'
    ```

---

- Create an alias in your `~/.bashrc` file for `nano ~/.bashrc`.

    - Run `echo "alias rc='nano ~/.bashrc'" >> ~/.bashrc`

    - Run `source ~/.bashrc` to reload the file and enable our commands.

    - Run `lsa` to demonstrate your custom `ls` command.

    - Run `docs` to demonstrate your custom `cd` command.

    - Run `rc` to demonstrate your custom `nano ~/.bashrc` command.

- Scroll to the bottom where the aliases are being added.

The section should look like:

```bash
alias lsa='ls -a'
alias docs='cd ~/Documents'
alias dwn='cd ~/Downloads'
alias etc='cd /etc'
alias rc='nano ~/.bashrc'
```

Add a comment above your aliases to mark the section:

```bash
# Custom Aliases
alias lsa='ls -a'
alias docs='cd ~/Documents'
alias dwn='cd ~/Downloads'
alias etc='cd /etc'
alias rc='nano ~/.bashrc'
```

---

Create aliases in your `~/.bashrc` file for the four commands from the previous exercise.

1. `mkdir ~/research && cp /var/logs/* /etc/passwd /etc/shadow /etc/hosts ~/research`

    - Run `echo "alias logs='mkdir ~/research && cp /var/logs/* /etc/passwd /etc/shadow /etc/hosts ~/research'" >> ~/.bashrc`

2. `sudo find / -type f -perm /4000 > ~/research/suid_lst.txt`

    - Run `echo "alias suid='sudo find / -type f -perm /4000 > ~/research/suid_lst.txt'" >> ~/.bashrc`

3. `ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head > ~/research/top_processes.txt`

    - Run: `echo "alias aux='ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head > ~/research/top_processes.txt'" >> ~/.bashrc`

4. `ls home > ~/resources/users.txt && cat /etc/passwd | awk -F ":" '{if ($3 >= 1000) print $0}' >> ~/resources/users.txt`

    - Run: `echo "alias users='ls home > ~/research/users.txt && cat /etc/passwd | awk -F ":" '{if ($3 >= 1000) print $0}' >> ~/research/users.txt'" >> ~/.bashrc`

The `Custom Aliases` section should now look like:

```bash
# Custom Aliases
alias lsa='ls -a'
alias docs='cd ~/Documents'
alias dwn='cd ~/Downloads'
alias etc='cd /etc'
alias rc='nano ~/.bashrc'
alias logs='mkdir ~/research && cp /var/logs/* /etc/passwd /etc/shadow /etc/hosts ~/research'
alias suid='sudo find / -type f -perm /4000'
alias aux='ps aux -m | awk {"print $1, $2, $3, $4, $11"} | head'
alias users='ls home > ~/research/users.txt && cat /etc/passwd | awk -F ":" '{if ($3 >= 1000) print $0}''
```

We can either keep the output file redirection `>> ~/research/users.txt` or we can leave it out. If we do leave it out, we can still use redirection when we run our custom alias.

- Save and quit Nano.

- Type `suid >> ~/research/users.txt` as an example of using redirection with a custom alias.

Remember, with every edit, you will need to reload the `~/.bashrc` file before the edits will take effect.

- Run `source ~/.bashrc`

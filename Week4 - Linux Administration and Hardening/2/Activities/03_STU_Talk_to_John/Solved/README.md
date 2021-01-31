## Solution Guide: Let's Talk to John

The goal of this activity was to check for weak user passwords, and to change the password expiration date and password requirements for all users.

The main tasks we needed to complete were:

- Edit the `/etc/shadow` file so only the relevant users on the system were present.

- Use `john` to crack the passwords in this file, and save all the passwords to the research folder.

- Use the `chage` command to set a `90` day password expiration for seven users.

- Use the `chage` command to force immediate password expiration for seven users.

- Edit the `/etc/security/pwquality.conf` file to force users to set stronger passwords.

Completing these steps is good practice for setting password expirations and cracking passwords out of the `/etc/shadow` file.

### Walkthrough

Begin by editing your copy of the `/etc/shadow` file located in your `~/research` directory. You can always make a new copy if needed.

Run `nano ~/research/shadow`

- Edit the file so the only lines are for users `root`, `jack`, `adam`, `sally`, `billy`, `max` and `http`.

- Your file should look similar to this:

```bash
jack:e4932e5f0777e29422f4b2523f548faa:17874::::::
adam:e4932e5f0777e29422f4b2523f548faa:17874:0:99999:7:::
sally:e4932e5f0777e29422f4b2523f548faa:17874:0:99999:7:::
billy:e4932e5f0777e29422f4b2523f548faa:17874:0:99999:7:::
max:e4932e5f0777e29422f4b2523f548faa:17874:0:99999:7:::
http:e4932e5f0777e29422f4b2523f548faa:17874:0:99999:7:::

```

- Run `john` and pass that file as argument.

- Run `sudo john <your_file>`

- While `john` is running, check the password expiry information of each user account.

- Open another terminal window by right-clicking on the terminal.

- Run `sudo chage -l <account_name>` to check the information for each account.

- Modify each user on the system so that the password expires every 90 days.

    - Run `sudo chage -M 90 <account_name>` for each user

- Record any passwords you find into another file in your research folder. You may first need to consult the manual for `john` to find the passwords.

    - Run `man john` to see `To see cracked passwords, use: john -show passwd` just a bit down on the page.

- Run `sudo john -show passwd <your_file>`

- Run `sudo john -show passwd your_file > ~/research/passwords.txt` to save these passwords to a text file.

    - You could also do this manually by creating a text document with Nano.

- You should be able to crack the following passwords fairly quickly:

    - `root` : toor

    - `jack` : lakers

    - `adam` : farrai

    - `billy`: football

    - `sally` : 123456

    - `max` : welcome

    - `http` : website

- Force immediate password expiration for each of these seven users.

    - Run `sudo chage -d 0 <account_name>` to force a password change on the next login.

- Edit the `/etc/security/pwquality.conf` file to force users to set 16 character passwords with special characters and numbers.

  - Run `sudo nano /etc/security/pwquality.conf`

     - Add option `minlen = 16`

      -   Add option `minclass = 4`

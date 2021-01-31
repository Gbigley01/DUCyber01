## Activity File: Shutting Out `SUID`

**NOTE:** Before completing this activity, the setup script for Day 3 should be executed. 
  - Run `~/Documents/setup_scripts/sysadmin/day3_stu_setup.sh`

- As a junior administrator, you've audited the passwords on the system, removed some groups and malicious users, and locked down the sensitive `/etc/passwd` and `/etc/shadow` files.

- The senior system administrator is now worried about the `SUID` bit being set on programs owned by `root`. As we just learned, this can leave the system open for compromise in the future.

- Today your senior administrator asked you to audit the system for all files that have the `SUID` bit set for the root user. 

  They provided a list of programs that _should_ have these settings, which you can compare with your findings.

- Here are the main steps you must complete:
  - Search the `/usr/bin` directory for **all** files that have the `SUID` bit set.

  - Compare this list with the list provided by your administrator.
  - Document any files that are not on your list.
  - Verify whether any suspect files you find will allow a vulnerability to be exploited. 

### Instructions

  - When searching for `SUID` bit executables, focus on the `/usr/bin` directory.

  - Here is a list of the only programs that should have the `SUID` bit set in `/usr/bin`:

    ```bash
    /usr/bin/chsh
    /usr/bin/chfn
    /usr/bin/passwd
    /usr/bin/gpasswd
    /usr/bin/newgrp
    /usr/bin/pkexec
    /usr/bin/sudo
    /usr/bin/traceroute6.iputils
    /usr/bin/arping
    ```

- Start by searching the `/usr/bin` directory for all files that have the `SUID` bit set.
  - Note any files you find that should not have the `SUID` bit set.

  - Use a long listing to verify that the `SUID` bit is set.

- For any programs you find with `SUID`, verify whether a vulnerability is present.

  _**Hint**: Switch to a user that does not have `sudo` privileges and attempt to run commands as `root`_.

  - **Bonus Task 1:** Can you exploit any vulnerabilities in order to read or make a copy of `/etc/shadow` from an unprivileged user?

  - **Bonus Task 2:** Can you exploit any vulnerabilities in order to gain `sudo` or `root` access from an unprivileged user?

- Finally, change the permissions to remove the `SUID` bit for any programs that should not have it. 

---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

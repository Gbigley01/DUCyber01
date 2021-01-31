## Activity File: Log Filtering

The goal of this activity was to use `journalctl` and `rsyslog` to filter log files. Massive amounts of information exist within Linux logs, and the challenge is in knowing how to extract it.

### Solutions

Refer to the solutions below for this `journalctl` and `rsyslog` activity.

#### journalctl

-  Check if `journalctl` is running in persistent mode to ensure that logs are saved across reboots.

- The solution to this simply involves checking the `/etc/systemd/journald.conf` for `Storage`:

    - Run `grep Storage /etc/systemd/journald.conf`

    Output should appear as below:

    ```Bash
    Storage=auto
    ```
    - **NOTE** Notice that the storage option is uncommented, which indicates that the auto storage option is enabled.

- Use `journalctl` to list boots for the system to establish a record of boot times.

  - Run `sudo journalctl --list-boots`

  Output should appear _similar_ as below (you'll likely have a different number of boots): 

  ```bash
  -2 b9d78ad1fd1b41e08eabc818d8707d03 Sun 2019-10-20 09:09:10 PDT—Sun 2019-10-20 20:45:01 PDT
  -1 4e30c0e11d314e83b8f2c0579195ab98 Sun 2019-10-27 09:26:37 PDT—Sun 2019-10-27 09:41:57 PDT
  0 fff45efd4fa9408399e434a3597efd07 Sun 2019-10-27 09:43:27 PDT—Sun 2019-10-27 10:50:13 PDT
  ```

- Use `journalctl` to list only the errors associated with the most recent boot.

  - Run `sudo journalctl -p err -b -0`

- Use `journalctl` to check logs for all cron jobs since yesterday.

  - Run `sudo journalctl -u cron -S yesterday`

  Output should appear as below: 

  ```bash
  -- Logs begin at Sun 2019-10-20 09:09:10 PDT, end at Sun 2019-10-27 11:03:04 PDT. --
  Oct 27 09:26:40 ubuntu systemd[1]: Started Regular background program processing daemon.
  Oct 27 09:26:40 ubuntu cron[724]: (CRON) INFO (pidfile fd = 3)
  Oct 27 09:26:40 ubuntu cron[724]: (CRON) INFO (Running @reboot jobs)
  Oct 27 09:41:53 ubuntu systemd[1]: Stopping Regular background program processing daemon...
  Oct 27 09:41:53 ubuntu systemd[1]: Stopped Regular background program processing daemon.
  -- Reboot --
  Oct 27 09:43:29 ubuntu systemd[1]: Started Regular background program processing daemon.
  Oct 27 09:43:29 ubuntu cron[708]: (CRON) INFO (pidfile fd = 3)
  Oct 27 09:43:29 ubuntu cron[708]: (CRON) INFO (Running @reboot jobs)
  Oct 27 10:17:01 ubuntu CRON[2129]: pam_unix(cron:session): session opened for user root by (uid=0)
  Oct 27 10:17:01 ubuntu CRON[2129]: pam_unix(cron:session): session closed for user root
  ```

- Use `journalctl` to check for current system disk usage for `systemd-journald`. What is the `max` setting size?

  - Run `sudo journalctl -u systemd-journald | less`

  Output should appear as below: 

  ```bash
  -- Logs begin at Sun 2019-10-20 09:09:10 PDT, end at Sun 2019-11-03 10:54:30 PST. --
  Oct 20 09:09:10 ubuntu systemd-journald[332]: Journal started
  Oct 20 09:09:10 ubuntu systemd-journald[332]: Runtime journal (/run/log/journal/ebad1179078943b4bc83aee99ce9e0b3) is 2.4M, max 19.6M, 17.2M free.
  Oct 20 09:09:10 ubuntu systemd-journald[332]: Time spent on flushing to /var is 27.087ms for 1573 entries.
  Oct 20 09:09:10 ubuntu systemd-journald[332]: System journal (/var/log/journal/ebad1179078943b4bc83aee99ce9e0b3) is 8.0M, max 1.9G, 1.9G free.
  Oct 20 20:45:01 ubuntu systemd-journald[332]: Journal stopped
  ```

- Use `journalctl` to remove all archived journals except the most recent five.

  - Run `sudo journalctl --vacuum-files=5`

  Output should appear as below:

  ```bash
  Deleted archived journal /var/log/journal/ebad1179078943b4bc83aee99ce9e0b3/system@70905245e4554b5385d134fba6a0a393-0000000000000001-00059559c995596e.journal (120.0M).
  Vacuuming done, freed 120.0M of archived journals from /var/log/journal/ebad1179078943b4bc83aee99ce9e0b3.
  ```

- **Bonus** Use `journalctl` to remove all archives journals older than 1 year.

  - Run `sudo journalctl --vacuum-time=1year`

  Output should appear as below:

  ```bash
  Vacuuming done, freed 0B of archived journals from /var/log/journal/ebad1179078943b4bc83aee99ce9e0b3.
  ```

#### rsyslog

- Check if the `rsyslog` service is running.

  - Run `systemctl status rsyslog`

  Output should appear as below: 

  ```bash
  ● rsyslog.service - System Logging Service
    Loaded: loaded (/lib/systemd/system/rsyslog.service; enabled; vendor preset: enabled)
    Active: active (running) since Sun 2019-10-27 09:43:30 PDT; 1h 45min ago
      Docs: man:rsyslogd(8)
            http://www.rsyslog.com/doc/
  Main PID: 709 (rsyslogd)
      Tasks: 4 (limit: 2290)
    CGroup: /system.slice/rsyslog.service
            └─709 /usr/sbin/rsyslogd -n
  ```
- Verify that `/var/log/cron.log` doesn't exist.

  - Run `ls /var/log | grep cron `

- Edit `/etc/rsyslog.d/50-default.conf` and create an entry that tells the `rsyslog` daemon to save all messages coming from the cron daemon in a file called `/var/log/cron.log`.

  - First, stop the rsyslog service.

    - Run `sudo service rsyslog stop`

  - Then, edit `/etc/rsyslog.d/50-default.conf` and uncomment `cron`.

    - Run `sudo nano /etc/rsyslog.d/50-default.conf`

    Output should appear as below:

    ```bash
    #  Default rules for rsyslog.
    #
    #                       For more information see rsyslog.conf(5) and /etc/rsyslog.conf

    #
    # First some standard log files.  Log by facility.
    #
    auth,authpriv.*                 /var/log/auth.log
    *.*;auth,authpriv.none          -/var/log/syslog
    cron.*                          /var/log/cron.log
    #daemon.*                       -/var/log/daemon.log
    kern.*                          -/var/log/kern.log
    #lpr.*                          -/var/log/lpr.log
    mail.*                          -/var/log/mail.log
    #user.*                         -/var/log/user.log
    ```

- Restart the rsyslog service.

  - Run  `sudo service rsyslog start`

- Then verify that `/var/log/cron.log` exists.

  - Run  `ls /var/log | grep cron`

  Output should appear as below:

  ```Bash
  cron.log
  ```

**Note**: You may have to wait a few moments for the `cron.log` to generate.

- **Bonus:** Configure `rsyslog` to only record messages with priorities above `info` for mail alerts.

  - Run `sudo nano /etc/rsyslog.d/50-default.conf`

  - Add `mail.!=info /var/log/mail.info` under the `mail.err` entry

  The new mail alert priority configuration should appear as below in `/etc/rsyslog.d/50-default.conf`:

    ```bash
    # Logging for the mail system.  Split it up so that
    # it is easy to write scripts to parse these files.
    #
    #mail.info                      -/var/log/mail.info
    #mail.warn                      -/var/log/mail.warn
    mail.err                        /var/log/mail.err
    mail.!=info                     /var/log/mail.info
    ```


---
 © 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  
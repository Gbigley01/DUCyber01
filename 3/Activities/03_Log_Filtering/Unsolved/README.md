## Student Activity: Log Filtering

In this activity, you are a junior administrator at Rezifp Pharma Inc. The company maintains a large database of files associated with patients, doctors, and their treatments. These files are maintained on a local server.

- It has been brought to your attention by the senior security manager that there was a suspicious logon from a host on the network during the early morning hours, when the office is closed.

- No one should be logging on during those hours, per corporate policy. You’ve been tasked with filtering through log files to determine if there was a system breach.

### Instructions

Log management is a critical part of a security administrator’s responsibilities. Auditing log files provides the security admin an opportunity to trace a series of historical events to establish whether a breach has occurred.

Today you will audit four logs that are critical to providing insight into an attacker's activities.

Remember, you can use Google and man pages to help you complete this activity.

#### journalctl

In your Ubuntu VM, launch a terminal and complete the following tasks:

1. Check if `journalctl` is running in persistent mode, to ensure that logs are saved across reboots.

2. Use `journalctl` to list boots for the system, to establish a record of boot times.

3. Use `journalctl` to list only the errors associated with the most recent boot.

4. Use `journalctl` to check logs for all cron jobs since yesterday.

5. Use `journalctl` to check for current system disk usage for `systemd-journald`. What is the `max` setting size?

6. Use `journalctl` to remove all archived journals except the most recent five.

**Bonus:** Use `journalctl` to remove all archived journals older than one year.

#### rsyslog

1. Check if the `rsyslog` service is running.

2. Verify that `/var/log/cron.log` doesn't exist.

3.   Edit `/etc/rsyslog.d/50-default.conf` and create an entry that tells the `rsyslog` daemon to save all messages coming from the cron daemon in a file called `/var/log/cron.log`.

4. Stop the `rsyslog` service.

5. Edit `/etc/rsyslog.conf` and uncomment `cron`.

6. Restart the rsyslog service.

7. Verify that `/var/log/cron.log` exists.

**Bonus:** Configure `rsyslog` to only record messages with priorities above `info` for mail alerts.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  
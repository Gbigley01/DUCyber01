## Activity File: Log Size Management

In this activity, you are a junior administrator at Rezifp Pharma Inc. The company maintains a large database of patient data associated with patients, doctors, and their treatments. These files are maintained on a local server.

After installing and configuring Tripwire as your primary file manipulation detection system, you discovered that log files are deleted every morning.

Your organization currently does not have a log rotation scheme in place. Your CISO has asked that you create a `cron` job to rotate logs out every morning at 3 a.m. This is an effort to keep log files smaller and more manageable during backups.

### Instructions

The primary benefits of log rotation are preserving log entries and keeping log file sizes manageable. When a log file is rotated, the preserved log file can be compressed to save space.

Today you will create a log rotation scheme that keeps four weeks' worth of logs with a daily rotation that includes a maximum file size of 1 GB.

In your Ubuntu VM, launch a terminal. 

1. 	Check your Logrotate version for documentation purposes.

2. List the contents of `logrotate.d` to see what configuration files are present.

3. Configure/ensure the following parameters for Logrotation by editing `/etc/logrotate.conf` to include the following parameters:

   - A rotation scheme keeping four weeks of backlogs.

   - Create new empty log files after rotating old ones.

   - Do not rotate empty logs.

   - Compress log files.

4. Add the following directories to be rotated:

    - For the log rotation rules for `/var/log/auth.log`, use the following parameters: `180 days of backlog`, `rotate daily`, `Don't rotate empty logs`, `Compress the file`, `Delay the compression`.

    - For the log rotation rules for  `/var/log/cron.log`, use the following parameters: `60 days of backlog`, `rotate weekly`, `Don't rotate empty logs`, `Compress the file`, `Delay the compression`.

    - For the log rotation rules for  `/var/log/boot.log`, use the following parameters: `30 days of backlog`, `rotate daily`, `Don't rotate empty logs`, `Compress the file`, `Delay the compression`.

5. Test the rotation by forcing Logrotation to rotate the logs by verifying the dates.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  
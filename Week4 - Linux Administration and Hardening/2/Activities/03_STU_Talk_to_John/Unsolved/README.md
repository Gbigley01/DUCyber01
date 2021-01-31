## Activity File: Let's Talk to John

In the previous class, you were acting as a junior administrator. Following the instructions provided by a senior administrator, you audited the system for malicious files and processes and installed some programs that we will use to further your audit. Among the the collected files was a system file that contains all of the user passwords in a hash.

Users typically use very weak passwords. We want to audit these passwords by attempting to crack them with the same tool hackers often use. Once we have their passwords, we can log in as the user and complete additional auditing tasks by navigating the system from their account, accessing their files, and testing their system access against known vulnerabilities.

In this activity, your senior administrator has asked you to audit the strength of users' passwords using the `john` program and document any passwords that you find.

They also asked you to:
  - Change the password expiration for each user to 90 days.
  - Force every password to expire immediately.
  - Require 16 character passwords with special characters and numbers.

To complete these tasks, you will use the program `john` on the password files that you copied on Day 1. You will use `john` to crack the passwords for all the users on the system. You will document all the passwords you find in your research directory, set new password expiration dates for each user, and change the password strength configuration to force more secure passwords in the future.

### Instructions

1. Yesterday you saved several files to your research folder. One of these files contains all of the password hashes for the system. If you do not still have that file, make another copy of `/etc/shadow` and save it in your research directory.

2. Open the file using `nano`. Delete the lines for the admin user, root user, and any other user whose password you do not want to crack.
     - **Note**: Password cracking can take a long time, so the fewer passwords you leave in the file, the better.

3. Run `sudo john` and pass that file as argument.
     - **Note**: This command is all you need to crack passwords. While this program is running, you can complete other tasks.

4. While `john` is running, check the password expiry information of each user account.
    - **Hint**: If you have trouble, remember you can use the man pages and Google to find more info on `john`.
5. Modify each user on the system so that the password expires every 90 days.

6. Record any passwords you find and place them in another file in your research folder.
   - **Hint**: You should be able to crack seven passwords.

7. Force immediate password expiration for each of these user accounts.

8. Edit the `/etc/security/pwquality.conf` file to force users to set 16 character passwords with special characters and numbers. 

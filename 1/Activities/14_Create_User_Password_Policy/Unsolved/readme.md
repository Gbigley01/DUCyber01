## Activity File: Creating Users and Setting Password Policies

In the previous activity, you used the `net` command-line tool to find various types of information, such as the `localgroups` on the machine, and the existing password policy, with `accounts`.

Your CIO noticed the previous password policies were not very strict, and wants to enforce new password policies on this Windows workstation for the next two new users: senior developer Andrew, and sales representative Bob.

- You are asked to create a regular user, `Bob`, and an administrative user, `Andrew`, and set the password policies with the following parameters:

  - Maximum password age to 90 days.

  - Minimum password length to 12 characters.

  - Password complexity requirements to be enabled.

Please complete the following using the **Windows Hyper-V virtual machine**. 

### Instructions

#### Create a regular user.

1. Create a regular user, Bob, using the `net user` command-line tool.

2. Set the user's password to `Ilovesales123!`. They will change this on their first day.
    - Note that `net user [username] *` will also let you change the password of an existing user (if you added the user without setting the password, or set it improperly). 

#### Create an administrative user with elevated privileges.

3. Create a user, Andrew, and add him to the `administrator` group.

4. Set the user's password to `Ilovedevelopment123!`. They will change this on their first day.

5. Use `net` to verify that Andrew is _only_ in the `administrator` group.

#### Set the Windows workstation's password policy.

6. Launch `gpedit` and set the following password policies for the entire Windows machine:

    - Maximum password age to 90 days.
    
    - Minimum password length to 12 characters.
    
    - Password complexity requirements to be enabled.

----

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

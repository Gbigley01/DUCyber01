## Solution Guide: Creating Users and Setting Password Policies

In this activity, you used `net` to create two different kinds of users: a regular `user` and a `localgroup` Administrator user, and set new password policies. 

---

#### Create a regular user.

  - Run `net user Bob Ilovesales123! /add`

    - `net user Bob *` will also let you change the password of an existing user (if you added the user without setting the password).

#### Create an administrative user with elevated privileges.

- Create a user to add to the `administrator` group.

  - Run `net user Andrew Ilovedevelopment123! /add`

  - Running `net user Andrew *` will also let you change the password of an existing user (if you added the user without setting the password).

- Now add Andrew to the `administrators` group.

  - Run `net localgroup administrators Andrew /add`

- Check Andrew's groups.

  - Run `net user Andrew`

#### Set the Windows workstation password policy.

- Run `gpedit` and navigate to `Windows Settings` > `Security Settings` > `Account Policies` > `Password Policies`. Set the following:

    - Set `Maximum password age` to `90` days. While `Maximum password age` is highlighted, right-click it, and click on `Properties` to see the tabs for enabling and disabling the option. You can also go to the `Explain` tab to see what best practices exist for password expiration policies.
    
    - Set `Minimum password length` to `12 characters`.
    
    - Double-click on `Password must meet complexity requirements`, and set to `Enabled`. Select `Apply`, then click on the `Explain` tab to read the following:

  ```console
  Password must meet complexity requirements

  This security setting determines whether passwords must meet complexity requirements.

  If this policy is enabled, passwords must meet the following minimum requirements:

  Not contain the user's account name or parts of the user's full name that exceed two consecutive characters
  Be at least six characters in length
  Contain characters from three of the following four categories:
  English uppercase characters (A through Z)
  English lowercase characters (a through z)
  Base 10 digits (0 through 9)
  Non-alphabetic characters (for example, !, $, #, %)
  Complexity requirements are enforced when passwords are changed or created.
  ```

----

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

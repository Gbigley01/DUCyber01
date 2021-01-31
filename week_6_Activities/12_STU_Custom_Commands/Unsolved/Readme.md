## Activity File: Custom Commands

- In the previous activity, you created your first bash script that contained a series of commands. This system audit script should save you time during your audits.

- Now, you will continue to make this script more complex by adding a few commands from the first exercise. 

- Then, you will save this script to a `scripts` directory and add that directory to your `$PATH` so you can call your script directly on the command line, from any directory.


To complete this activity, you will need to do the following:

- Start by ensuring your script from the last activity runs as expected.

- Add the new commands listed in the instructions to your script.

- Save your script in a `~/scripts` directory.

- Add your `~/scripts` directory to your `$PATH`.

- Run your script to verify it produces the correct output.

#### Instructions

Complete the following inside your script. 

- Add the command for creating a `~/research` directory to your script.

- Add the command for finding `SUID` files to your script.

- Add the command for finding the Top 10 processes to your script.

- Modify each command of the script so that it writes all output to a file called `~/research/sys_info.txt`.

Complete the following in your command line environment:

- Manually create a `~/scripts` directory and save your script there. (This should not be part of your script).

- Add your `~/scripts` directory to your `$PATH`.

- Reload your bashrc file.

- Run your script.

- Open `~/research/sys_info.txt` and verify it has the desired output.

---
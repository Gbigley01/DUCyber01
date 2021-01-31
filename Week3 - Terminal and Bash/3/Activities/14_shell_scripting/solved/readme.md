## Solution Guide: My First Shell Script

- The first step is to navigate into the `first_shell_script` directory. To do this, run the following commands:
 
  -  `cd Cybersecurity-Lesson-Plans/03-Terminal/student_day3`
  - `cd first_shell_script`
       
- Within this directory is a log file called `LogA.txt`.  

- We will use `nano` to create a shell script called `Log_analysis.sh`:

  - `nano Log_analysis.sh`
        
- We will place the two commands used in the previous activities inside this file:
  - `cat LogA.txt | sed s/INCORRECT_PASSWORD/ACCESS_DENIED/ > Update1_Combined_Access_logs.txt`
  - `cat Update1_Combined_Access_logs.txt | awk -F" " '{print $4, $6}' > Update2_Combined_Access_logs.txt`
 
    - Make sure that the first command references `LogA.txt`. 
     
- Save the Nano file using Ctrl+O, and keep the file name.

- Run the shell command with the following:

  - `sh log_analysis.sh`
        
- Confirm the results are correct by checking the new file called `Update2_Combined_Access_logs.txt`.

  - Within this file should only be the date and username.

---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

## Solution Guide: Internal Investigation: Finding the Kit Cat Burglar

- First, navigate into the `Cybersecurity-Lesson-Plans/03-Terminal/student/find_kit_cat_burglar` folder on your VM. To do this, run the following commands:
  -   `cd Cybersecurity-Lesson-Plans/03-Terminal/student/`
  - `cd find_kit_cat_burglar`

-  This directory has folders for evidence gathered from Henry and Ruth.

- Within Henry and Ruth's directories are sub-directories for:
     - Emails
     - Files
     - Logs
     - Other

- To preview all the files in each of these directories and find those that can be used as evidence, you can use `more`, `less`, or `head`.

  - The files that contain "evidence" to provide to the authorities are: 

    * `root/student/find_kit_cat_burglar/ruth/emails/emailA`
    * `root/student/find_kit_cat_burglar/ruth/files/sd.txt`
    * `root/student/find_kit_cat_burglar/henry/emails/email1`
    * `root/student/find_kit_cat_burglar/henry/emails/email4`
    * `root/student/find_kit_cat_burglar/henry/logs/log1`
    * `root/student/find_kit_cat_burglar/henry/logs/log2`
    * `root/student/find_kit_cat_burglar/henry/other/top_secret/recipe_for_sugarplum`
    * `root/student/find_kit_cat_burglar/henry/other/top_secret/recipe_for_sweetums`     
   
- Next, go back to  the `find_kit_cat_burglar` directory, and make a directory called `Evidence_for_authorities`. Run the following command:

  - `mkdir Evidence_for_authorities`

- Copy all the evidence files found into this directory. To do this, run the following commands using absolute paths:
            
       cp root/student/find_kit_cat_burglar/ruth/emails/emailA   root/student/find_kit_cat_burglar/Evidence_for_authorities
       cp root/student/find_kit_cat_burglar/ruth/files/sd.txt     root/student/find_kit_cat_burglar/Evidence_for_authorities
       cp  root/student/find_kit_cat_burglar/henry/emails/email1  root/student/find_kit_cat_burglar/Evidence_for_authorities
       cp  root/student/find_kit_cat_burglar/henry/emails/email4   root/student/find_kit_cat_burglar/Evidence_for_authorities
       cp  root/student/find_kit_cat_burglar/henry/logs/log1    root/student/find_kit_cat_burglar/Evidence_for_authorities
       cp   root/student/find_kit_cat_burglar/henry/logs/log2  root/student/find_kit_cat_burglar/Evidence_for_authorities
       cp  root/student/find_kit_cat_burglar/henry/other/top_secret/recipe_for_sugarplum    root/student/find_kit_cat_burglar/Evidence_for_authorities
       cp  root/student/find_kit_cat_burglar/henry/other/top_secret/recipe_for_sweetums  root/student/find_kit_cat_burglar/Evidence_for_authorities
    
-  The last step is to concatenate all the files together. Move into `Evidence_for_authorities` and run:
   - `cat  emailA sd.txt  email1 email4 log1 log2     recipe_for_sugarplum  recipe_for_sweetums > Wonka-evidence.txt` 

 **Bonus**
 
 - The hidden file is `lp.txt` in Ruth's file directory.

 - To change the file extension from .txt to .jpg, run:
   - `mv lp.txt  lp.jpg`

 - Open the file to display a picture of the candy.  

--- 
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

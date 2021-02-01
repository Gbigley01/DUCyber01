## Student Guide: Final Project Week

### Overview 

This week, you will work on your final project by completing the following tasks:

- Implement the alarms and thresholds you determined would be effective in Project 2.

- Assess two more vulnerable VMs and verify that the rules work as expected.

- Use Wireshark to analyze live malicious traffic on the wire.

You will complete each of these activities **individually**. You will then work in groups of three to six to develop presentations for the final day of class. 

### Lab Environment 

This week's lab environment is an Azure Classroom Lab containing a modified version of the Project 2 network. In particular, it includes the following machines:

- **Capstone** (`192.168.1.105`): The vulnerable target VM that you will attack to test alerts. Filebeat and Metricbeat are installed and will forward logs to the ELK machine. 
   - Please note that this VM is in the network solely for the purpose of testing alerts.

- **ELK** (`192.168.1.100`): The same ELK setup that you created in Project 1. It holds the Kibana dashboards.

- **Kali** (`192.168.1.90`): A standard Kali Linux machine for use in the penetration test on Day 1. 
   - Credentials are `root`:`toor`.

- **Target 1** (`192.168.1.110`): Exposes a vulnerable WordPress server.

- **Target 2** (`192.168.1.115`): Exposes the same WordPress site as above, but with better security hardening. It must be exploited differently than Target 1.

### Task Breakdown

The following breakdown describes the tasks you will be assigned and a recommended timeline for achieving each milestone. 

#### Day 1: Target 1

After your instructor reviews the project overview and demonstrates how to use `wpscan` to assess a WordPress target, you will configure alerts in Kibana and test them by repeating attacks against the Capstone VM. Then you will begin your assessment of the first vulnerable VM: Target 1.

- [Activity File: Attacking Targets 1 and 2](Activities/Day-1/Unsolved/ReadMe.md)


#### Day 2: Target 1

On Day 1, you will complete an assessment of Target 1. Those of you who complete this task may move on to the Wireshark analysis.

- [Activity File: Attacking Targets 1 and 2](Activities/Day-1/Unsolved/ReadMe.md)


#### Day 3: Analysis

After assessing the Target 1, you will use the Kali VM to capture and analyze traffic on the virtual network with Wireshark. You will analyze the traffic to explain what users are doing on the network. After analyzing Wireshark traffic, you will spend the remainder of class completing summaries of your work. If all of the above is complete, you may complete the assessment of Target 2. Instruction are available in the Day 1 activity file. 

- [Activity File: Wireshark Strikes Back](Activities/Day-3/Unsolved/ReadMe.md)


#### Day 4: Presentations

You will work in groups, complete the deliverables of the project, and present your findings to the class in short presentations. 

- [Activity File: Final Group Presentations](Activities/Day-4/Group-Presentations.md)

### Report and Presentation Templates

To complete the project, you will need to fill out the reports and slide decks linked below. The templates are on Google Drive (you must make a copy of each).   

- **Reports:** The Defensive Report and the Offensive Report relates to the Days 1 and 2, and the Network Report relates to Day 3. You can complete these as you work through the activites, outside of class, or on Day 3, during the time reserved for completing the project deliverables. The reports must be completed individually.

    - [Offensive Report Template](https://docs.google.com/document/d/1QBlLFY5yHU1oGn_zxxJWUBuR1BqEGHShx6R9Leyj670/edit#)
     - [Defensive Report Template](https://docs.google.com/document/d/1-BqgAVle0B1ZIBcAtyle2Qi-19-uodmEE96zUKvFzhw/edit)
   - [Network Report Template](https://docs.google.com/document/d/109JqFQrFcftu1AdSqoecA7CU45q4aKsEQb1FN7AbfS0/edit#)


- **Presentations:** On Day 3, you will work in groups of three to six to complete the three slide decks below, and present them as a group: 

   - [Offensive Presentation Template](https://docs.google.com/presentation/d/19ouk_AS16V-f1KiJ3FTnNpJ4SJn1QQG3vkKukEN1NvU/edit#slide=id.g630a814dc5_0_53)
   - [Defensive Presentation Template](https://docs.google.com/presentation/d/1LP9TBdUYlWut3Qu4Czf618i-kg_qjjxkbnWLNTSdJBk/edit#slide=id.g630a814dc5_0_53)
   - [Network Presentation Template](https://docs.google.com/presentation/d/1LLh9dyrXNkWLqcsOnu5C_LOFDm_1EuKSf7y-Z7DwXn8/edit#slide=id.g630a814dc5_0_53)


---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  

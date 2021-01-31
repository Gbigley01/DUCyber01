### Linux Stress Optional Activity

Welcome! 

This is an optional activity for the Project week. It should only be completed after _all_ other aspects of the project are complete.


It is not required to complete the project and can be completely ignored if you wish.
#### Scenario

You are a cloud architect that has been tasked with setting up an ELK server to gather logs for the Incident Response team.

Before you hand over the server to the IR team, your senior architect has asked that you verify the ELK server is working as expected and pulling both logs and metrics from the pen-testing web servers.

Your task: Generate a high amount of CPU usage on the pen-testing machines and verify that Kibana picks up this data.

---

#### Instructions

The Metrics page for a single VM shows the CPU usage for that machine. This provides insight into how much work the machine is doing. Excessively high CPU usage is typically a cause for concern, as overworked computers are at greater risk for failure.

Metricbeat forwards data about CPU load to Elastic Search, and this data can be visaulized with Kibana.

In this activity, you will intentionally stress the CPU of one of your VMs, then find evidence of the increased activity in Kibana.

Linux has a common, easy-to-use diagnostic program called `stress`. It is easy to use and can be downloaded via `apt`.

**Using Stress:**

From your Jump-Box, start up your `Ansible` container and attach to it.

SSH from your Ansible container to one of your WebVM's.

Run `sudo apt install stress` to install the stress program.

Run `sudo stress --cpu 1` and allow stress to run for a few minutes. 

View the Metrics page for that VM in Kibana. 

What indicates that CPU usage increased?

**Your Task:**

- Run the `stress` program on all 3 of your VM's and take screen shots of the data generated on the metrics page of Kibana.

**NOTE:** The stress program will run until you quit with `ctrl + c`.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved. 
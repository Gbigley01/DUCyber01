## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

https://github.com/Gbigley01/DUCyber01/blob/main/images/ELK-Project-Diagram.svg

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the _____ file may be used to install only certain pieces of it, such as Filebeat.

  - ansible_config.yml

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly _____, in addition to restricting _____ to the network.
- _TODO: What aspect of security do load balancers protect?  Protects againts DDoS
-What is the advantage of a jump box? allows you to securely access a network remotely 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the _web application_ and system _logs_.
- _TODO: What does Filebeat watch for?_Requests, uploads and changes to file system data
- _TODO: What does Metricbeat record?_ system data such as metrics from the operating system and service running on the server.

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name        | Function      | IP Address        | Operating System     |
|---------    |-----------    |---------------    |------------------    |
| Jumpbox     | Gateway       | 104.43.229.91     | windows              |
| Web-1       | Container     | 10.0.0.12         | windows              |
| Web-2       | Container     | 10.0.0.13         | windows              |
| ELK         | Logs          | 51.143.32.182     | windows              |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the _JumpBox_ machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- _TODO: Add whitelisted IP addresses_ 73.217.117.94

Machines within the network can only be accessed by _The Jump Box VM_.
- _TODO: Which machine did you allow to access your ELK VM? What was its IP address?_the JumpBox is alloud to access my ELK VM and the ip address is 10.0.0.4

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | No              |              73.217.117.94    |
|          |                     |                      |
|          |                     |                      |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- _TODO: What is the main advantage of automating configuration with Ansible?_ The main advantage of automating configuration with ansible is that it frees up time for andministrators so they can focus on more pressing tasks to defend the system more efficiently. 

The playbook implements the following tasks:
- _TODO: In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
- configure the ELK VM with Docker, on it's own host and user.
- Install docker.io, install python3-pip, install docker module
- increase virtual memory
- Download and Launch docker elk container

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- _TODO: List the IP addresses of the machines you are monitoring_
- 10.0.0.12
- 10.0.0.13
- 10.0.0.5
- 10.0.0.6

We have installed the following Beats on these machines:
- _TODO: Specify which Beats you successfully installed_

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _filebeat_config.yml_ file to _Ansible container_.
- Update the _filebeat_config.yml_ file to include... the ELK server IP address 51.143.32.182
- Run the playbook, and navigate to _ filebeat installation page on the elk server_ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? filebeat_playbook.yml  Where do you copy it?_copied onto the web VM's
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running? http:// 51.143.32.182:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._

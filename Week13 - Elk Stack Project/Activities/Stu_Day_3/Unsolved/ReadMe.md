## Day 3 Activity File: Network Diagramming and README

Today's class is dedicated to completing the installation of Filebeat and finalizing your network diagram.

If you've already finished installing Filebeat, congratulations! The final steps are to:
1. Finalize the network diagram you began during the cloud security week.
2. Draft a README explaining what you've built.
---

### Instructions 

#### 1. Diagramming the Network

Now that you've deployed your ELK instance, your virtual network is "stable." You won't be adding anything to it for awhile.

Since the network is essentially complete, it's time to document what you've built. This is an important last step for any deployment.

Use [Gliffy](https://www.gliffy.com) or [Draw.io](https://draw.io) to diagram your network. Make sure your diagram includes:

- **VNet**: Create a box thate contains the machines on your virtual network. Within your VNet, diagram the following:
  - Jump box and other VMs.
  - Ansible control node.
  - Specify which VM hosts the DVWA containers.
  - Specify which VM hosts ELK stack containers.

- **Security group**: Create a box around your VNet to indicate the security group, and use a text field to specify the rules you have in place.

- **Access from the internet**: Add an icon representing the public internet and indicate how it connects to VMs in your VNet.

Use a text field to label each VM with the following information:
- Network (IP) address
- Operating system and version
- Installed containers
- Exposed ports
- Allowed IP addresses

#### 2. Completing the README

As you know, all technical projects come with some sort of documentation to serve as a technical brief. One of the most common forms of documentation is the README file, which is a simple markdown file containing information about a project. 

README formats vary across projects, but you can use this template to get started: [README.zip](../../../Resources/README.zip).

- Download and unzip the template. Inside, you'll find a file called `README.md`, which contains the template. Much of the contents are provided, but you must fill in the "TODO" fields.

- You will also notice an `Images` folder. A few TODO items require you to place screenshots in your `README.md`. Place your screenshots in the `Images` folder, and update the `README.md` template with the appropriate file name.  

For homework, you will create a GitHub repository where you will save your project files and this README. Your repository will include
- Your network diagram.
- A description of the deployment.
- Tables specifying access policies and network addresses.
- Usage instructions.

This professional-level repository will prove that you have the knowledge and communication skills that hiring managers are looking for.

While it may feel less substantial than the project itself, one of the most important skills a cybersecurity professional can have is the ability to articulate what they know. The README is an important capstone to the project and will serve as a compelling portfolio item for prospective employers.


#### Bonus

If you finish early or want to make further refinements to your deployment on your own time, consider the following next steps:

- Refer to the [official Ansible documentation](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html) refactor your project to use roles instead of a single playbook. 
- Create roles for two other Beats. If you're feeling ambitious, create roles for every Beat that can be installed on Linux.

---

### Turn off Your Machine

After completing your diagram, finishing the README, and presenting your work, make sure to **turn off** your virtual machines.

- Navigate to portal.azure.com.
- Search for and select "Virtual machines."
- Select every VM in the list.
- Click **Stop**. This will ensure you're never charged for any of the machines you used in the project.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  

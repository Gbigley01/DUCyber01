## Activity File: Container Intrusion Detection System (CIDS)

For this activity, you will play the role of a DevSecOps engineer.

- Risk Management approved the use of the outdated WordPress container. However, they stipulated that you include a container runtime intrusion detection system on the host system for your containers.

- You are tasked with setting up and testing the container security runtime engine Falco with the WordPress container.

- You are tasked with setting up and testing the container security runtime engine Falco with the WordPress container.


### Falco Setup

1. Open a terminal and navigate back to the `/home/sysadmin/Cybersecurity-Lesson-Plans/14-Web_Dev/deploying_testing_activity` directory.

2. Run `sudo docker-compose up`. 

3. With the first terminal still open, open a new terminal and navigate to `/home/sysadmin/Cybersecurity-Lesson-Plans/14-Web_Dev/falco`.

4. Run the Falco script with `sudo ./falco.sh`. This will launch Falco in its own container (microservice).

- **Note**: If it does not launch, make sure that the `falco.sh` file is executable with `sudo chmod +x falco.sh`.

This Falco terminal will now display any detected anomalies.

### Instructions

Test each of the following indicators of intrusion and answer the questions that follow:

- **Shell Spawn**: In a production scenario that stands up many containers, at no point in your deployment, should a new shell session be started to any of the containers. So we're going to test this! 

  - Start a bash session in the front-end (`wp`) container. We'll call this the "intrusion session".

  - Check the Falco terminal to see what it says after you connect. As a reminder, the command is `sudo docker exec -it wp bash`.

- **Sensitive File Read**: When an attacker gains access to a system, they may try to retrieve sensitive files. Sensitive files such as `/etc/shadow` contain the hashed passwords of users on a system and should never be accessed at any point during the container's runtime.

  - While still in the `wp` container's bash session, read the contents of `/etc/shadow`.

  - Check the Falco terminal again. What kind of alert severity was this? Was this different than the shell spawn alert? If so, how?

  - What kind of program does Falco say opened the sensitive file?

- **Modifying Configuration File**: After a container is deployed, users should remain static and not change. User setups should be declared in the Dockerfiles and any change in users indicates someone an outside attack.

  - While still in the `wp` container's bash session, create a new user using `adduser notahacker`. Give this user any password and complete the prompts to finalize adding the user.

  - What is the alert severity in the Falco terminal?

- **File Creation at `/root`**: When a container is running, the `/` directory and `/root` directory should remain unchanged, since they are the top-level and privileged level directories. Changes to the directory and files can indicate compromise.

  - Attempt to create a file in the `/root` directory.

  - What is the alert severity?

- Enter Ctrl+C in the Falco terminal to stop the container and see the results. What do you see? 

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  

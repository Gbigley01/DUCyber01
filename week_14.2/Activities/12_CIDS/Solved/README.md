## Solution Guide: Container Intrusion Detection System (CIDS)

In this activity, you tested Falco's monitoring capabilities. 

---

**Shell Spawn**: 
 
- Enter an interactive session into the front-end container with: `docker exec -it wp bash`.

- You should see the following message in the Falco terminal:

   `Notice A shell was spawned in a container with an attached terminal (user=root <NA> (id=9b942802d3ff) shell=bash parent=runc cmdline=bash terminal=34816 container_id=9b942802d3ff  image=<NA>)` 

**Sensitive File Read:**

- Run `cat /etc/shadow` in the front-end bash session to see another alert in the Falco terminal: `sensitive file opened`.

- Instead of a `Notice` you should see a `Warning`.
  
  ```bash
  2020-03-26T16:23:00.974143096+0000: Warning Sensitive file opened for reading by non-trusted program (user=root program=cat command=cat /etc/shadow file=/etc/shadow parent=bash gparent=<NA> ggparent=<NA> gggparent=<NA> container_id=9b942802d3ff image=httpd)
  ```

- Falco will say a `non-trusted` program read the sensitive file.

**Modifying Configuration File**:

- Run `adduser notahacker` in the front-end bash session to see an alert: `shell configuration file has been modified`.

- The alert severity is again `Warning`:
  
  ```bash
  2020-03-26T16:23:34.195090906+0000: Warning a shell configuration file has been modified (user=root command=adduser /usr/sbin/adduser notahacker pcmdline=bash file=/home/notahacker/.bash_logout container_id=9b942802d3ff image=httpd)
  ```

**File Creation at `/root`:**

- Run `touch /root/exfiltration.sh` to see: `File below / or /root opened for writing`.

- The alert severity for this is `Error`.

  ```bash
  2020-03-26T16:31:03.174365309+0000: Error File below / or /root opened for writing (user=root command=touch exfiltration.sh parent=bash file=/root/exfiltration.sh program=touch container_id=9b942802d3ff image=httpd)
  ```

Enter `Ctrl+C` in the Falco terminal to stop the container and see the results.

- After using `Ctrl+C` to end the Falco session, we should see a summarized list of incidents and detections, similar to below:

  ```bash
  SIGINT received, exiting...
  Events detected: 7
  Rule counts by severity:
     ERROR: 1
     INFO: 1
     WARNING: 1
     NOTICE: 4
  Triggered rules by rule name:
     System procs network activity: 3
     Read sensitive file untrusted: 1
     Launch Privileged Container: 1
     Write below root: 1
     Terminal shell in container: 1
  Syscall event drop monitoring:
     - event drop detected: 0 occurrences
     - num times actions taken: 0
  ```

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  
## 11.2 Student Guide: Introduction to Intrusion Detection, Snort, and Network Security Monitoring

### Overview

Today, you will learn how to analyze indicators of attack, perform network forensics, and acquire intelligence and situational awareness of their networks.

### Class Objectives

By the end of today's class, you will be able to:

- Define network security monitoring (NSM) and explain its role in defense in depth.

- Interpret and define Snort rules and alerts.

- Explain how intrusion detection systems work and how they differ from firewalls. 

- Use Security Onion and its suite of network security monitoring tools to perform network forensics.

- Perform collection and analysis of indicators of attack as part of the NSM Detection stage.

- Apply knowledge of NSM, Snort rules, and Security Onion to analyze an indicator of attack and establish an attacker profile. 

### Slideshow 

The lesson slides are available on Google Drive here: [11.2 Slides](https://docs.google.com/presentation/d/1eozqcOqCpXY_lfZQY1YluCWeBXsV8fH6S3EYyLPa1iE/edit)

---

### 01. Security Onion Setup 

Before we get started, we will all log into Azure and launch an instance of Security Onion. This will generate alert data that we'll use to complete the labs.

- [Activity File: Security Onion Setup](Activities/01_Security_Onion_Setup/README.md)

### 02. Class Overview (0:05)

Let's begin by reviewing basic firewall concepts and discussing how they relate to professional roles:

- Firewalls protect networks by making decisions based on rules set by administrators. Firewalls are designed to allow traffic from trusted sources and block traffic from untrusted sources.

- Firewalls do have their limitations. They can easily be fooled through packet manipulation by clever hackers. 

   - For instance, attackers can send malicious data through a firewall by hijacking or impersonating a trusted machine. This is why it's crucial to have an effective defense in depth methodology to help protect sensitive data.

- **Intrusion detection systems** (**IDS**) are tools that can both analyze traffic _and_ look for malicious signatures. An IDS is like a firewall that also reads the data in the packets it inspects, issues alerts/alarms, and blocks malicious traffic if configured to do so.

   - There are many varieties of intrusion detection systems, but today's class will focus on **Snort**, the world's most popular open-source solution.

- **Network security monitoring** (**NSM**) is the process of identifying weaknesses within a network's defense. It also provides organizations with situational awareness of their network.

- Security Onion is a specific Linux distribution that's derived from Ubuntu. Security Onion uses the Snort IDS engine as its event-driven mechanism. 

#### Professional Motivation

This knowledge is essential for the following technical roles, among others:

- **Security analysts** are responsible for protecting all sensitive information within a company. Their main job is to analyze a company's security measures, determine how effective they are, and suggest ways to improve them.

- **Security Operations Center (SOC) analysts** provide visibility into an enterprises network. They monitor for security events and identify, analyze, defend against IT threats. 

- **Network Forensics** uncovers the source of security issues by monitoring and analyzing network events. 

### 03. Intro to Intrusion Detection Systems and Snort 

We discussed firewalls at length in the previous class. Today, we'll explore the world of intrusion detection systems, the role they play in a defense in depth strategy, and how they generally differ from firewalls.

A firewall is a device used in network security designed to filter ingress and egress traffic (inbound and outbound traffic respectively), based upon a set of predetermined administratively defined rules. 

Firewalls make decisions to either allow or block traffic based on the following:

- Source and destination IP address
- Source and destination oort number
- Protocol type

Firewalls operate among four different layers of the defense in depth model:

- Perimeter
- Network
- Host
- Application

Unlike firewalls, intrusion prevention and detection systems monitor, detect, and alert about an attack depending upon the configuration.

#### Intrusion Detection System Overview

Intrusion detection systems (IDS) are passive devices that perform packet captures of all traffic that passes through a network interface.

- Intrusion detection systems are not designed to _respond_ to an attack, but rather to document and log attacks for future analysis.

- Intrusion detection systems help organizations enforce the cyber kill chain by establishing situational awareness of their adversaries, which may include intent and end objectives. Organizations can use this information to harden their defenses.

#### IDS Types

There are two primary types of IDS:

- **Signature-based** IDS compares patterns of traffic to predefined signatures.
   - Good for identifying well-known attacks.
   - Requires regular updates as new attack signatures are released.
   - Vulnerable to attacks through packet manipulation that tricks the IDS into believing malicious traffic is good.
   - Unable to detect zero-day attacks.
   
- **Anomaly-based** IDS compares patterns of traffic against a well-known baseline.
   - Good for detecting all suspicious traffic that deviates from the well-known baseline.
   - Prone to issuing false alerts.
   - Assumes normal network behavior never deviates from the well-known baseline.
   - Excellent at detecting when an attacker probes or sweeps a network.

#### Intrusion Detection Architecture

Intrusion detection systems have two basic architectures:

- **Network intrusion detection system** (**NIDS**) filters an entire subnet on a network.
   - Matches all traffic to a known library of attack signatures.
   - Passively examines network traffic at the points it is deployed.
   - Relatively easy to deploy and difficult to detect by attackers.

- **Host-based intrusion detection system** (**HIDS**) runs locally on a host-based system or user’s workstation or server.
   - Acts as a second line of defense against malicious traffic that successfully bypasses a NIDS.
   - Examines entire file systems on a host, compares them to previous snapshots or a baseline, and generates an alert if there are significant differences between the two.

![NIDS](Images/NIDS.png)
![NIDS](Images/HIDS.png)

[Image Source](https://www.comparitech.com/net-admin/network-intrusion-detection-tools/)

**Intrusion Prevention System**

An **intrusion prevention system** (**IPS**) does everything that an IDS can do, but can also respond to attacks. An IDS doesn’t alter or react to packets as they enter the network. An IPS does this by blocking malicious traffic and preventing it from being delivered to a host on the network.

![IDS vs IPS](Images/IDSvsIPS.png)

The two main differences of an IPS and IDS:

- IDS physically connects via a network tap or mirrored port or SPAN.
  
   - **Network tap** (Test Access Port) is a hardware device that provides access to a network. Network taps transit both inbound and outbound data streams on separate channels at the same time, so all data will arrive at the monitoring device in real time.

   - **SPAN** (Switched Port Analyzer), also known as **port mirroring**, sends a mirror image of all network data to another physical port, where the packets can be captured and analyzed.

   - IDS requires an administrator to react to an alert by examining what has been flagged.

- IPS physically connects inline with the flow of data. An IPS is typically placed in between the firewall and network switch. 

   - Requires more robust hardware due to the amount of traffic flowing through it.
   - Automatically takes action by blocking and logging a threat, thus not requiring administrative intervention.

An IDS generates an alert when a Snort rule detects malicious traffic that matches a signature. An alert is a message that’s created and sent to the analyst’s console as an **indicator of attack** (**IOA**).

There are two primary types of indicators:

- Indicators of attack indicate attacks happening in real time.
   - Proactive approach to intrusion attempts.
   - Indicate that an attack is currently in progress but a full breach has not been determined or has not occurred yet. 
   - Focus on revealing the intent and end goal of the attacker regardless of the exploit or malware used in the attack.

- **Indicators of compromise** (**IOC**) indicate previous malicious activity. 

   - Reactive approach to successful intrusions.
   - Indicate that an attack occurred, resulting in a breach.
   - Used to establish an adversary's techniques, tactics, and procedures (TTPs).
   - Expose all of the vulnerabilities used in an attack, giving network defenders the opportunity to revamp their defense as part of their mitigation strategy, and learn from an attack so it won't happen again.


#### Snort

Snort is a freely available open-source network intrusion detection\prevention system. It can perform real-time traffic analysis and log packets on a network. Snort is used to detect a wide variety of attacks.

- Snort adds additional layers of defense that can be applied at various layers of the defense in depth model, including:
  
   - Perimeter IDS and IPS architecture
   - Network IDS and IPS architecture
   - Host IDS and IPS architecture

- Configuration Modes

   Snort can operate in three modes:

   - **Sniffer Mode**: Reads network packets and displays them on screen.
   
   - **Packet Logger Mode**: Performs packet captures by logging all traffic to disk.

   - **Network Intrusion Detection System Mode**: Monitors network traffic, analyzes it, and performs specific actions based on administratively defined rules.

Most Snort deployments use all three modes of operation.

#### Snort Rules

Snort uses rules to detect and prevent intrusions. Snort operates by:

1. Reading a configuration file.

2. Loading the rules and plugins.

3. Capturing packets and monitoring traffic for patterns specified in the loaded rules.

4. When traffic matches a rule pattern, generating an alert and/or logging the matching packet for later inspection.

Rules can direct Snort to monitor the following information:
- OSI layer: Watches for IP vs. TCP data.

- Source and destination address: Where the traffic is flowing from and to. 

- Byte sequences: Patterns contained in data packets that might indicate malware, etc.

Consider the following Snort rule: 

 - `alert ip any any -> any any {msg: "IP Packet Detected";}`
   
- This rule logs the message "IP Packet Detected" whenever it detects an IP packet.

Another example: 

`alert tcp any any -> 10.199.12.8 21 {msg: "TCP Packet Detected";}`
 
   - This rule triggers an alert when a TCP packet with `any` source IP address from `any` port, is sent to the IP addess `10.199.12.8` on port `21`. It will print the message "TCP Packet Detected" with each alert detection.

   - Rule Header
      - `alert`: The **action** that Snort will take when triggered. 
      - `tcp`: Applies the rule to all `TCP` **packets**.
      - `any`: Applies the rule to packets coming from `any` **source IP address**.
      - `any`: Applies the rule to packets from `any` **port**.
      - `->`: Indicates the **direction of traffic flow**.
      - `10.199.12.8`: Applies the rule to any packet with this **destination IP address**.
      - `21`: Applies the rule to traffic to **destination port** `21`.

  - Rule Option

    - `{msg: "TCP Packet Detected";}`: The message printed with the alert.

   ![Snort Rule](Images/SnortRule.png) 

- Snort provides many additional actions and protocols, which can be combined to design rules for almost any type of packet.


### 04. Intrusion Detection Systems and Snort Activity

- [Activity File: Intrusion Detection Systems and Snort](Activities/04_IDS_and_Snort/Unsolved/README.md)

### 05. Review Intrusion Detection Systems and Snort Activity

- [Solution Guide: Intrusion Detection Systems and Snort](Activities/04_IDS_and_Snort/Solved/README.md)

### 06. Instructor Do: Network Security Monitoring and Security Onion (0:20)

#### Network Security Monitoring Overview

On November 24, 2014, a hacker group called Guardians of Peace released confidential information from Sony Pictures that contained personally identifiable information for all its employees, including full names, home addresses, social security numbers, and financial information.

- It was later discovered that the assailants had been lurking in Sony's network for 17 months prior to the discovery of the breach. 

- As a result, a number of executives and upper management were fired, all employees had their PII exposed, and the company suffered massive damage to its reputation. Sony was also forced to pay large fines for violating federal regulations.

If Sony Pictures had put a network security monitoring program in place, they would have discovered the attack much sooner, perhaps within hours.

-  NSM would have allowed Sony to stop the attack immediately, while gaining a good understanding of the tactics, techniques, and procedures (TTPs) used by the adversary to penetrate the network. 

- This could have been accomplished by adding additional layers of defense in the form of an NIDS, NIPS, and HIDS as part of an NSM program.

Security monitoring highlights the failures of existing security controls through the use of data analysis tools. NSM is most useful when the front-end layers of defense are compromised. 

It takes time for intruders to achieve their objectives. In many cases, infiltrators spend hours, weeks, months, or even years inside of a network before achieving their final objectives. It’s during this critical time that NSM can work to slow and/or eliminate threat-based attacks. 

- NSM is threat-centric. Its primary focus is the adversary, not the vulnerability.

- NSM is focused on visibility of an attack, not the response to the attack. 

- NSM also reveals statistical data related to specific IOAs and IOCs from attacks.

#### NSM Strengths

NSM can only protect against the adversarial tactics that it can detect. This detection process takes place when collected data is inspected and irregularities are identified.

NSM allows organizations to:
- Track adversaries through a network and determine their intent.
- Acquire intelligence and situational awareness.
- Be proactive by identifying vulnerabilities.
- Be reactive through incident response and network forensics.
- Provide insights related to advanced persistent threats (APTs).
- Uncover and track malware.

#### NSM Weaknesses

It’s important for security administrators to know the limits of their defenses so they can better prepare new ones. NSM capabilities are extremely limited in the following situations:

- Encrypted traffic and VPNs: NSM and IDS do not have the capability to read encrypted traffic. Adversaries will often use this tactic to bypass security defenses.

- Underpowered hardware: NSM and IDS require adequate amounts of processing and memory to function well. Larger networks have more traffic, requiring more powerful hardware requirements, and larger expenses.

- Mobile communication platforms: Adversaries often use mobile radio communications to obfuscate their attacks because it's difficult for NSM and IDS to monitor radio transmission waves.

- Legal and privacy issues: NSM is an invasive process that monitors and records all network data as it passes through. Therefore, there may be legal implications regarding certain types of data collected by an NSM.

- Limited access to network taps: The placement of an NSM sensor can be limited at certain areas of the network.

#### NSM Stages and Processes

NSM operates under two distinct stages, each with two processes.

- **Detection**: In this stage, an alert is first generated in the Sguil analyst's console. (Sguil, which you'll learn about in a moment, is a tool that collects alert data from Snort. )

   - **Collection**: The event is observed and the data is stored in a PCAP file. 
   
   - **Analysis**: The alert data is identified, validated, documented, and categorized according to its threat level.
   
- **Response**: In this stage, a security team responds to a security incident with two processes:

   - **Escalation**: All relevant individuals are notified about the incident.
   
   - **Resolution**: The process of containment, remediation, and any additional necessary response.
   

![NSM Process](Images/NSMProcess.png)

#### NSM Sensor Connectivity

Intrusion detection systems are generally placed at strategic locations in a network where traffic is most vulnerable to attack. These devices are typically placed next to a router or switch that filters traffic.

An IDS can be physically connected to a network in two ways:

- **Mirrored port or SPAN**: A SPAN port is a function of an enterprise-level switch that allows you to mirror one or more physical switch ports to another port. A mirror image of all data will flow across both ports equally. This is what allows the IDS to perform packet captures on all inbound and outbound traffic within a network.
  
  ![SPAN or Mirrored Port](Images/SPANPORT.png)

- **Network Test Access Point (TAP)**: TAPs allow us to access our network and send that data in real time to our monitoring systems. One example of a TAP is known an aggregated TAP, in which a cable connects the TAP monitor port with the NIC on the sensor. This specific placement allows traffic to be monitored between the router and switch.  

  ![Network Tap](Images/NetworkTap.png)

#### Security Onion

Today we'll work with Security Onion, a network security monitoring platform that provides context, intelligence, and situational awareness of a network.

- Security Onion is an Ubuntu-based, open source Linux distribution that contains many NSM tools used to protect networks from attacks. Security Onion adds multiple layers of defense and helps enforce the cyber kill chain.

We'll be using a few NSM tools to help us with an incident detection and response routine that will simulate a real world situation.

The tools we will be using are:

- **Sguil**: Pulls together alert data from Snort. It provides important context for alerts,  which we can use to complete more detailed analysis of the data. 

- **Transcript**: Provides us a view of PCAP transcripts that are rendered with `tcpflow`, the equivalent to following TCP streams in Wireshark.

- **NetworkMiner**: Performs advanced network traffic analysis. Extracts artifacts from PCAP files and provides an intuitive user interface to analyze them with. Allows the analyst to analyze, reassemble, and regenerate transmitted files and certificates from PCAP files.

### Alert Data

Snort watches and interprets network traffic and creates a message when it sees something it is programmed to report. These alerts are based on patterns of bytes, counts of activity, or even more complicated options that look deeply into packets and streams. 

#### Sguil

Sguil has six key functions that help NSM analysts with their work:

  - Performs simple aggregation of alert data records.

  - Makes available certain types of metadata and related data.

  - Allows queries and review of alert data.

  - Allows queries and review of session data.

  - Allows easy transitions between alert or session data and full content data, which is rendered as text in a transcript or in a protocol analyzer like Wireshark.

  - Exposes features so analysts can count and classify events, enabling escalation and other incident response decisions.

Sguil is made up of four main sections:

- **Alert Panel**: Displays detailed alert data, including:
   - Source and destination IP
   - Source and destination port
   - Alert ID/severity
   - Event message (message generated by Snort rule option)

- **Snort Rule**: The Snort rule that generated the alert, obtained from the IDS engine.

- **Packet Data**: PCAP file showing header and payload information of the data.

- **IP Resolution**: Displays reverse DNS lookup information.

#### Sguil's Alert Panel

As shown in the screenshot, the Snort IDS generated the alert `GPL ATTACK_RESPONSE id check returned root`. The analyst must decide if this is benign or malicious. This demonstration will focus on how to obtain data and use tools and process to make this decision.

![Squil Alert Panel](Images/Squil%20Alerts.png)


- The alert panel has four fields that we should look at:

  - **ST or Status**: Colors indicate severity levels of "real-time" or "RT" events.
   
     - **Red**: Critical, possible data breach in progress. Must be resolved immediately.
     - **Orange**: Moderate, high potential for data breach. Requires immediate review.
     - **Yellow**: General, low potential for data breach. Requires review.

  - **Alert ID**: A randomly generated numerical ID created by Sguil to itemize alert data.
  - **Source IP**: IP address of the source identified by the alert.
  - **Event Message**: The message generate by the Snort rule option.


#### Sguil's Snort Rule and Packet Data Sections

The next screenshot is an example of the Snort rule set in Squil that activated this alert.

- **Snort Rule**: In the top portion of the window, we see the Snort NIDS engine that generated the alert data when traffic matched one of its rules. 
   - Alert data is an indicator of attack. An analyst may have to determine if it represents benign or malicious activity. 
   
   - Alert data from the Snort NIDS stores entries in the Event Messages column that begin with text like "ET" (for Emerging Threats, an IDS rule source).
   
- **Packet Data**: The lower, more colorful part of this window is the portion of Sguil that performs network packet analysis. 
  
   - The packet analyzer shows a detailed view of the data capture. It includes packet header information and data streams presented in hex and text form.

![Alert Rule](Images/Rules.png)

#### Sguil's IP Resolution Section

This section of Sguil's analyst console provides reverse DNS lookup information. This is used to reveal identifying information about the attacker. This includes their domain name registries and IP addresses.

- Other information may include the country of origin, and, ideally, the names, email addresses, and/or phone number of the DNS registrants.

Analysts can use the data obtained from IP resolution to formulate attacker profiles. 

![IP Resolution](Images/Reverse%20DNS.png)


### 07. Security Onion and NSM Overview 


- [Activity File: Security Onion and NSM Overview](Activities/07_Security_Onion_NSM/Unsolved/README.md)


### 08. Review Security Onion and NSM Overview Activity 

- [Solution Guide: Security Onion and NSM Overview](Activities/07_Security_Onion_NSM/Solved/README.md)


### 09. Instructor Do: Alert - FTP File Extraction (0:15)

There will be many times when an alert requires an analyst to do some data mining. A security analyst must have a thorough understanding of how NSM tools are integrated in order to do this. These skills help speed up incident and response efforts.

In the following walkthrough, we will explore the Security Onion interface, using Sguil as the starting point for learning other NSM tools for security investigations.

#### Security Onion Demo

The first thing we will do is search using a filter for the IP address from the indicator of attack (IOA).

Launch an instance of Security Onion. Do the following steps:

- Click the Sguil desktop icon and launch the application.
  
- When prompted, select **both** networks to monitor. 
  
- Click **Query** in the top toolbar.

- Click **Query by IP** in the dropdown menu.

   ![Query Pivot](Images/Query%20Pivot.png)

Next, input the IP address that we obtained from the IOA alert:

- Enter the IP address obtained from the alert: `128.199.52.211`.

- Click **Submit**.

  ![IP Builder](Images/IP%20Builder.png)

Now, we will only see information related to our filtered alert data, as seen below.

1. Alert information: 
   - NSM sensor that triggered the alert.
   - Source and destination IP.
   - Source and destination port.
   - Date and time of the alert.
   - Event message (defined in the Snort IDS rule option used to generate the alert).

2. Reverse DNS lookup information.

3. Snort rule that triggered the alert.

4. Server response message in the packet data section.

   ![Filtered Alert](Images/Filtered%20Alert.png)

Since we've now compiled critical information from the attack signature, we have a partial picture of the attack profile. Let's continue our network forensic investigation.

From the information we've gathered so far, we can conclude the following:

- This attack occurred as the result of a **drive-by** attack that used the HTTP protocol. 

   - A drive-by attack is when a user navigates to a webpage that has built-in malicious scripts running in the background. 

   -  Drive-by attacks are dangerous because the user doesn't need to click anything on the webpage to launch the attack. The mere act of opening the webpage creates a session in the background without the user knowing, which prompts malicious software downloads. 

- Now that we have this knowledge, we know we must search for any files that may have been downloaded to this particular host (the victim).

- Next, we'll introduce a new forensic tool that can extract any files that were installed on the user's machine, and provide us with an attacker profile.

#### NetworkMiner

NetworkMiner is an NSM tool that's included as part of the Security Onion NSM suite of tools. 

   - NetworkMiner performs advanced network traffic analysis (NTA) of extracted artifacts, and presents them through an intuitive user interface. 

From our Sguil window, we will switch to NetworkMiner by following the steps below. 

**Instructor Note**: Details may vary slightly from screenshot but the concepts still apply.
- Sort the alert IDs from low to high by clicking on **Alert ID** at the top of the column. Right-click on the first Alert ID at the top. 

- Click on **NetworkMiner** in the dropdown menu.


![Network Minor Pivot](Images/Network%20Minor%20Pivot.png)

- Now we are presented with NetworkMiner's interface. Pay attention to the tabs at the top. We'll focus on the **Files** tab next.

- Select the **Files (4)** tab as seen in the screenshot. This tells us that NetworkMiner was able to extract and reconstruct the four files used in the attack, from Security Onion's PCAP captures.

- Source port and protocol used (Box 3).

- Protocols used during transmission (Box 4).

![Network Minor Files](Images/Network%20Minor%20Files.png)

- Right-click on one of the files.

- Click on **Open folder**.

![Open Folder](Images/Open%20Folder.png)

- This will open the folder on the local hard disk where NetworkMiner stores the recompiled files.

![Files Folder View](Images/Files%20Folder%20View.png)

- Next, open the Chromium Web Browser, navigate to www.virustotal.com, and select **File**.

- These are parts of the malware. We can click and drag on any one of the files and get results. Drag the `d10.octet-stream` file to the **Choose file** box in the VirusTotal window.

![Drag n Drop](Images/Malicous%20File%20Drag.png)

This opens the VirusTotal search tool, which will attempt to match these files to any known malware signatures.

- VirusTotal returned the number of matches it discovered for well-known virus engines against this particular file.

- VirusTotal hashes the files, which establishes a malware signature used to look for a match and determine the common name for the malware.

- VirusTotal lists all of the common names for this specific malware.

Security professionals, especially security researchers, use this website frequently when performing malware analysis and establishing the tactics, techniques, and procedures used by adversaries to infiltrate networks. This information contributes to what is commonly referred to in the industry as an "attacker profile." These help us know our enemies in order to better defend against future attacks.

![Virus Total](Images/Virustotal.png)

#### Summary

- Computer Incident Response Teams can use the vast amount of information accumulated by NSM to formulate the tactics, techniques, and procedures used by an adversary. 

- NSM allows organizations to establish situational awareness within their networks by enforcing the cyber kill chain.


### 10. Alert - FTP File Extraction 

- [Activity File: Alert - FTP File Extraction ](Activities/11_(Alert)_FTP_File_Extraction/Unsolved/README.md)

### 11. Review Alert - FTP File Extraction 

- [Solution Guide: Alert - FTP File Extraction](Activities/11_(Alert)_FTP_File_Extraction/Solved/README.md)


### 12. Alert - ET INFO Executable Download

NSM highlights the failures of existing security controls using a wide variety of data analysis tools. 

- NSM is useful when most of the front-end layers of defense have been compromised.

- The strength of NSM is its focus on visibility of an attack, not its control. NSM builds a picture of the adversaries TTPs, intent, and end objectives.

In the following demonstration, we will use Security Onion to look more closely at the intent behind a specific attack, and establish a more detailed picture of the adversary's TTPs.

####  Security Onion Demo 

Launch an instance of Security Onion and do the following:

- Sort through the alerts by clicking on the **Dst IP** column, and list the alerts from low to high. Click on the alert that has `10.0.3.15` as its destination IP.

- In this alert, we can see the Snort rule option defined this attack as an `Emerging Threat Policy violation for a malicious file download` via the HTTP protocol on port `80`.

![Squil Alert](Images/EXE_DOWNLOAD_INST_DO/Squil_Alert.png)

Switch to Transcript by right-clicking on the Alert ID and scrolling down. Use the screenshot as reference. 

1. We can see there was a GET request from the source that downloaded images through a vulnerability that exists within the Shockwave Flash application.

2. PThe destination responded with "OK," establishing the connection.

3. We can also see the file transfer is encrypted. Often, attackers will transfer encrypted files to a victim's machine to obfuscate their tracks and subvert an IDS. Remember, NSM cannot see inside encrypted files. However, NSM can extract and then reassemble a file after it has been decrypted on a victim's computer.

![Transcript](Images/EXE_DOWNLOAD_INST_DO/Transcript_Header.png)

Even though files may be encrypted during transmission, there may be times, typically towards the end of the transmission, were the file names are sent in plain text as seen in the image below. 

These files are being imported and installed on the breached system so the adversary can command and control it. This moves the adversary through the last three stages of the cyber kill chain:

- Installation
- Command and Control
- Actions on Objectives

Here we can see four DLL files that will be used to modify the victim's registry, most likely to establish persistence. 

![DLL Files](Images/EXE_DOWNLOAD_INST_DO/DLL_FILES.png)

Next we will switch to NetworkMiner and try to establish an attacker profile.

- Open NetworkMiner and do the following on the `10.0.3.15` (Windows) host:

  - Click on the **Hosts (2)** tab.
  - Expand **`10.0.3.15` (Windows)**.
  - Expand **OS: Windows**.
  - Expand **Host Details**.
  - Expand **`192.168.56.52` [sploitme.com.cn](Other)** host.
  - Expand **OS: (Other)**.
  - Expand **Incoming Sessions**.
  - Expand **Host Details**.
  
Note the following:

   - We are presented with the hardware address and manufacturer of the network interface card of the victim's machine.

   - NetworkMiner attempted to perform an OS fingerprint of the victim's machine. There is a 100% match for Windows XP Pro/2000 Pro.

   - We can see the web browser that was used during the attack was Mozilla Firefox.

  - Looking at the web server's information, NetworkMiner has fingerprinted the web server's operating system as Linux FreeBSD 4.5.

   - NetworkMiner enumerated the version of Apache and PHP in use on the web server, and was able to discern which software patch was in use.

All of this information will be included in a report for further analysis as part of the incident and response effort.


![NetworkMiner](Images/EXE_DOWNLOAD_INST_DO/Net_Miner.png)

Next, we will establish the TTPs used in this attack and try to uncover the intent of the adversary.

- Click on the files tab.

![NetworkMiner](Images/File_Tab.png)

- Extract the malicious files called `video[2].exe and video[3].exe`. 
  - Please note they could be named slightly differently depending on your enviroment.  

- Open the Chromium web browser and navigate to www.virustotal.com. Upload one of the video files.

- We have two virus engine matches, indicating that this file is malicious.

- Click on the **Details** tab.

![Details](Images/EXE_DOWNLOAD_INST_DO/Details.png)

On the **Details** tab, we can see the **PEiD**, which stands for Portable Executable Identifier, a software program whose purpose is to identify the "packer" (the software used to compile the malware). In this case, the attacker used software called MingWin32 GCC 3.x to compile the malware.

This information is useful to an incident and response investigation for malware analysis purposes. We will revisit this concept later in this course.

![PEiD](Images/EXE_DOWNLOAD_INST_DO/PEiD.png)

- In the image below, we see three file imports. 

   - `KERNEL32.DLL`

   - `USER32.DLL`

   - `msvcrt.dll`

- Malware authors create executables using import functions under the guise of Dynamic Linked libraries or DLLs in order to avert suspicion. 

- It's common for malware authors to use DLL libraries to hide imports by "packing" their executables inside of DLLs. This allows them to create backdoor network connections at any point in time.

This information is crucial to investigative teams during malware analysis and should be included in your report.

![Imports](Images/EXE_DOWNLOAD_INST_DO/Imports.png)

In the **Relations** tab, we can see all of the contacted URLs and domains that were involved in this attack. The information provided here is useful in establishing the techniques and procedures used by the adversary. We are starting to build a more detailed understanding of the attack.

The information presented here helps provide situational awareness for an organization. The TTPs used by an adversary will help reveal all of the vulnerabilities that were exploited in the attack. Armed with this information, organizations have the ability to mitigate future attacks by hardening their networks.

![Relations](Images/EXE_DOWNLOAD_INST_DO/Relations.png)

Next, click on the **Behavior** tab, and scroll down to the **Files Deleted** section.

![Behavior](Images/EXE_DOWNLOAD_INST_DO/Behavior.png)

In the **Files Deleted** section, we can see that the adversary deleted several files in an effort to cover their tracks and obfuscate their presence.

![Deleted Files](Images/EXE_DOWNLOAD_INST_DO/FIles_Deleted.png)

#### Summary

The strength of NSM depends on knowing the limits of what you can detect, developing an understanding of adversarial tactics, and applying that knowledge to detecting future attacks. This process happens when collected data is inspected and irregularities are identified.

NSM allows organizations to:

- Track adversaries through a network and determine their intent.
- Acquire intelligence and situational awareness.
- Be proactive by identifying vulnerabilities.
- Be reactive through incident response and network forensics.
- Provide insights related to advanced persistent threats (APTs).
- Uncover and track malware.

### 13. Alert - ET INFO Executable Download 

- [Activity File: Alert - ET INFO Executable Download](Activities/14_(Alert)_Executable_Download/Unsolved/README.md)

### 14. Review Alert - ET INFO Executable Download Activity 

- [Solution File: ET INFO Executable Download](Activities/14_(Alert)_Executable_Download/Solved/README.md)

---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.


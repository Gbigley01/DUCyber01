## Activity File: Threat Hunting - Cyber Threat Intelligence

In this activity, you will continue in your role as an SOC analyst for the California DMV. 

- The SOC has succeeded in detecting alerts since system launch. As a result, your CISO has advocated for additional funding.

- Now that you're more experienced using the NSM system, you’ve realized that you must detect threats early in the process, before they cause significant damage. 
 
- You’ve made the decision to move from traditional network-based IDS engines, such as Snort, to the more all-encompassing ESM that includes endpoint telemetry. This involves the deployment of endpoint collection agents in the form of a host-based IDS system using OSSEC.

- You've decided to include threat hunting as part of your defense strategy. You assembled a team of highly motivated security professionals to help you.

- In this activity, you will strengthen your knowledge of concepts related to intelligence gathering and incidence response as part of the ESM process. You can use any tool you've learned to hunt for any malicious threat.

### Instructions

Complete your hunt for a threat of your choosing, using this threat intelligence card template to document your findings: [Threat Intelligence Card](Threat_Intel_Card.docx). You'll need to answer the following questions:

1.  What indicator of attack did you use to begin your investigation?
      - Source IP
      - Destination IP
      - Source port
      - Destination port
      - Infection type (Trojan, Virus, Worm, etc.)
      - MIME type (if any)
      - Malware type (Ransomware, Zombie DDoS, RAT, etc.)  

2. What was the adversarial motivation (purpose of attack)?

3. What were the adversary's actions and tactics?

4. What are your recommended mitigation strategies?


 Use the example below to help guide your description of actions and tactics:

| TTP | Example |
| --- | --- |
| **Reconnaissance** | Information gathering stage against targeted victim. Information sources include: DNS registration websites, LinkedIn, Facebook, Twitter, etc. |
| **Weaponization** | After collecting information regarding infrastructure and employees, adversaries have the capability to establish attack vectors and technical profiles of targets such as: logical and administrative security controls, infil/exfil points, etc.|
| **Delivery** | The delivery of the weaponized payload, via email, website, USB, etc.|
| **Exploitation** | Actively compromise adversary’s applications and servers while averting the physical, logical, and administrative controls. Exploiting employees through social engineering. This stage prepares for escalation during the installation phase.|
| **Installation** | A.k.a., the persistence preparation phase. Activities include malicious software installation, backdoor implants, persistence mechanism, ie. Cron Jobs, AutoRun keys, services, log file deletion, and timestamp manipulation.|
| **Command & Control (C2)** | A command channel, most typically Internet Relay Chat (IRC) , used for remote control of a victim's computer.|
| **Actions on Objectives** | After achieving the equivalent of "Hands on Keyboard" access to a victim's systems, adversaries are now able to act their objectives.|
---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

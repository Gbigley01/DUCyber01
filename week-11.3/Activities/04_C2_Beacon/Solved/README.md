## Solution Guide: Alert - C2 Beacon

The goals of this activity were to practice investigating a C2 beacon acknowledgement attack, and to and reinforce concepts related to Snort IDS, Security Onion, and network security monitoring.

---

Open Sguil and filter the Attacker's Source IP `67.183.123.151`

1. What Snort rule triggered this alert?

    - `alert tcp $HOME_NET any -> $EXTERNAL_NET $HTTP_PORTS`

2. According to the Snort rule, what is the source port?

     - `49159`

From the Sguil console, right-click on the Alert ID and pivot to Transcript, then scroll to the bottom of the Transcript window.

3. What is the message in the HTML body?

    - `hi!`

Close the Transcript window and go back to the Snort rule window. Click on the research.zscaler.com URL. A web browser will launch and take you to the Zscaler website. Read through the article and then answer the remaining questions.  

 (If the link is down, use this link instead to answer the following questions: [New Asprox Variant Goes Above And Beyond To Hijack Victims](https://drive.google.com/file/d/1R0CK9-21MiCcRBoUo8GgFEXRAlaUdpO-/view)

4. What type of threat is this?

    -  Botnet

5. Did this threat remove Windows registry keys?

    - Yes

6. Why does this threat disable key Windows processes?

    - To preventing security admins from deleting it.

7. What does CnC stand for and what is it?

    - Command and Control or C2, a server that's used to establish and maintain communications with compromised systems on targeted networks. Attackers use C2 servers for sending commands to botnets.

8. What term is used to describe a computer that's under the control of a C2 server?

    - Zombie 

09. What is a sign that a computer may be under the control of a C2 server?

    - Slow internet speeds and/or slow computer.

10. Name two of the most popular techniques an adversary uses to infect a host with a botnet.

    - Email phishing and drive-by downloads.

11. What are two ways an organization can mitigate this type of a threat?

    - Blacklist the CnC server's IP address or install an intrusion prevention system (IPS) using a Snort rule that blocks these types of threat signatures.

12. How far up the cyber kill chain did this attack go?

    - All the way to Action on Objections.

13. What process does this threat use to hide when it's discovered?

    - It deletes itself.

14. Why is this threat considered persistent?

    - Because it survives across system reboots.

15. What message does the victim's computer send to the CnC server to let it know that it's alive, listening, and waiting?

    - `hi!`

16. What tactic does this threat use to remain hidden and unnoticed?

    - It runs as a hidden background process and not inside of an open window on the user's screen.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

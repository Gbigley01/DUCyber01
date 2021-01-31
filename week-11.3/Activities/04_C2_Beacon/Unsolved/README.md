## Activity File: Alert - C2 Beacon

In this activity, you will continue your role as an SOC analyst for the California Department of Motor Vehicles (DMV).

- Your organization has just experienced another attack. This attack is much more sophisticated. It’s a red alert that Snort has identified as an emerging threat: a C2 beacon acknowledgement attack.

- The entire network is down across the state. As long as the network is down, none of the DMV offices can issue or renew licenses or registrations, or complete driving tests.

- As part of the Computer Incident and Response Team (CIRT), you need to establish an attacker profile that includes the tactics, techniques, and procedures used by the adversary, and document all of your findings. Like a real security analyst, you may need to research other sources to answer all the questions.  

### Instructions

Use the following indicator of attack:

- Destination IP: Victim `192.168.204.137`

- Source IP: Attacker `67.183.123.151`

- Snort Message: `ET TROJAN W32/Asprox.ClickFraudBot CnC Beacon Acknowledgment`

**Note:** You'll notice many attacks targeting the victim IP address. Please make sure to focus on the `ET TROJAN W32/Asprox.ClickFraudBot CnC Beacon Acknowledgment` attack.


Open Sguil and filter the Attacker's source IP `67.183.123.151`

1. What Snort rule triggered this alert?


2. According to the Snort rule, what is the source port?


From the Sguil console, right-click on the Alert ID and pivot to Transcript, then scroll to the bottom of the Transcript window.  

3. What is the message in the HTML body?

Close the Transcript window and go back to the Snort rule window. Click on the research.zscaler.com URL. A web browser will launch and take you to the Zscaler website. Read through the article and then answer the remaining questions.  

 (If the link is down, use this link instead to answer the following questions: [New Asprox Variant Goes Above And Beyond To Hijack Victims](https://drive.google.com/file/d/1R0CK9-21MiCcRBoUo8GgFEXRAlaUdpO-/view)

4. What type of threat is this?


5. Did this threat remove Windows registry keys?


6. Why does this threat disable key Windows processes?


7. What does CnC stand for and what is it?


8. What is the term to describe a computer that's under the control of a C2 server?


9. What is a sign that a computer is under the control of a C2 server?


10. Name one of the most popular techniques an adversary uses to infect a host with a botnet.


11. What are two ways an organization can mitigate this type of a threat?


12. How far up the cyber kill chain did this attack get?


13. What procedure does this threat use to hide when it's discovered?


14. Why is this threat persistent?


15. What message does the victim's computer send to the CnC to let it know that it's alive, listening, and waiting?


16. What tactic does this threat use to remain hidden and unnoticed?

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

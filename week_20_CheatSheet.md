## Cheat Sheet

### Host Discovery

**ARP Scan**
```bash
$ netdiscover -r 192.168.0.1/24
```

**Ping Sweep**

```bash
$ nmap -pn 192.168.0.1/24
```

**SYN Scan with OS Detection**

```bash
$ nmap -Ss -A 192.168.0.1/24
```

### Brute Force Attacks

```bash
$ hydra -l $USERNAME -P /path/to/wordlist -s $TARGET_PORT -f -vV $TARGET_URL

# For example
$ hydra -l admin -P /usr/opt/wordlist.txt -s 80 -f -vV victim.com/vulnerable_folder
```

### Gunzip

```bash
# gunzip help menu
$ gunzip --help 

# example usage
$ gunzip zipfile.txt.gz
```
---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  

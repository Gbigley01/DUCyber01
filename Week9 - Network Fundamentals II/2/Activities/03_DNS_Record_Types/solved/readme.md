## Solution Guide: Analyzing DNS Record Types

In this activity, you used `nslookup` to analyze multiple DNS records for several domains, and answered several questions about your findings. 

Completing this activity required the following steps:

- Using `nslookup` for three domains. 

- Determining several DNS records types for each domain.

- Analyzing your findings. 
   
---

**acme.com** 

  - **A record**: 
    - Run `nslookup -type=A acme.com`
      
    - Results: 
      
    ```
    Name:    acme.com
    Address:  157.131.251.23
    ```
      
   - **NS record**: 

      - Run `nslookup -type=NS acme.com`
    
      - Results:
    
      ```
      acme.com        nameserver = ns2.indra.com
      acme.com        nameserver = dns.bitway.com
      acme.com        nameserver = ns1.indra.com
      ```
    
  - **MX record**:

    - Run `nslookup -type=mx acme.com`

    - Results:

      ```
      *** Can't find acme.com: No answer

      Authoritative answers can be found from:
      ```

**test.com**

- **A record**: 

  - Run `nslookup -type=A test.com`
  
  - Results: 
  
    ```
    Name:    test.com
    Address:  69.172.200.235
    ```

- **NS record**: 

  - Run `nslookup -type=NS test.com`
  
  - Results:
  
    ```  
    test.com        nameserver = ns65.worldnic.com
    test.com        nameserver = ns66.worldnic.com
    ```

- **MX record**: 

  - Run `nslookup -type=mx test.com`

  - Results: 
  
    ```  
    test.com        MX preference = 30, mail exchanger = lastmx.spamexperts.net
    test.com        MX preference = 20, mail exchanger = fallbackmx.spamexperts.eu
    test.com        MX preference = 10, mail exchanger = mx.spamexperts.com
    ```


**nmap.org**

- **A record**: 
  - Run `nslookup -type=A nmap.org`.
  
  - Results: 
    
    ```
    Name:    nmap.org
    Address:  45.33.49.119
    ```

- **NS record**: 

  - Run `nslookup -type=NS nmap.org`.
  
  - Results:
      
    ```  
      nmap.org        nameserver = ns4.linode.com
      nmap.org        nameserver = ns1.linode.com
      nmap.org        nameserver = ns2.linode.com
      nmap.org        nameserver = ns3.linode.com
      nmap.org        nameserver = ns5.linode.com
    ```
  
- **MX record**: 
  - Run `nslookup -type=mx nmap.org`.

  - Results: 
    
    ```
     nmap.org        MX preference = 5, mail exchanger = ALT1.ASPMX.L.GOOGLE.COM
     nmap.org        MX preference = 1, mail exchanger = ASPMX.L.GOOGLE.COM
     nmap.org        MX preference = 5, mail exchanger = ALT2.ASPMX.L.GOOGLE.COM
     nmap.org        MX preference = 10, mail exchanger = ASPMX3.GOOGLEMAIL.COM 
     nmap.org        MX preference = 10, mail exchanger = ASPMX2.GOOGLEMAIL.COM
    ```


Did any of the domains have more than one MX record? If so, why do you think that is? 

  - All of the domains have more than one MX record. It's useful to have more than one MX record as a backup in case one isn't available, or to provide load balancing for large volumes of emails.

For nmap.org, list the mail servers, from the highest to lowest priority.

- The servers are ordered by MX preference below. The servers with the same MX preference have the same priority.

  ```
  (HIGHEST) nmap.org        MX preference = 1, mail exchanger = ASPMX.L.GOOGLE.COM
            nmap.org        MX preference = 5, mail exchanger = ALT1.ASPMX.L.GOOGLE.COM
            nmap.org        MX preference = 5, mail exchanger = ALT2.ASPMX.L.GOOGLE.COM
            nmap.org        MX preference = 10, mail exchanger = ASPMX3.GOOGLEMAIL.COM 
  (LOWEST)  nmap.org        MX preference = 10, mail exchanger = ASPMX2.GOOGLEMAIL.COM
  ```

Were any of the domains missing MX records? If so, why do you think that is?

- Yes, acme.com is missing MX records. The response was: 

  ```
  Non-authoritative answer:
  *** Can't find acme.com: No answer

  Authoritative answers can be found from:
  ```

- This could mean that it is non-existent, or that it has been hidden from the public. 


Look up the SPF record for acme.com.
- The DNS query to look up the SPF record is:

  `nslookup -type=txt acme.com`

- The results are:
  
  ```
  v=spf1 a mx ip4:192.100.66.0/24 -all
  ```
  
  This specifies the range of IPs allowed to send emails on behalf of acme.com

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
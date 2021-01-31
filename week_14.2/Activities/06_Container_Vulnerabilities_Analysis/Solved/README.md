## Solution Guide: Container Vulnerability Analysis with Trivy and Bash

For this activity, you had to evaluate the risk profile of a container that the Developer Team wants to use to implement the systems engineer's design.

---

1. Set up and navigate to your `trivy_reports` directory:

    - `mkdir ~/Documents/trivy_reports`
    - `cd ~/Documents/trivy_reports`

2. Using Trivy, output, in JSON format, all vulnerabilities with high and critical severities:

    - `trivy --format json --output wp_all_vulns.json --severity "HIGH,CRITICAL" wordpress:4.6.1-php5.6-apache`

   This command saves the file `wp_all_vulns.json` in the current directory.

3. Show all of the vulnerabilities by running: `jq . wp_all_vulns.json`. 

4. To filter buffer overflows, denial of service, and privilege escalatation vulnerabilities into a new JSON file, run the following commands: 

    - `jq '.[0].Vulnerabilities[] | select(.Description | test("buffer overflow"))' wp_all_vulns.json > wp_bo_vulns.json`

    - `jq '.[0].Vulnerabilities[] | select(.Description | test("denial of service"))' wp_all_vulns.json > wp_dos_vulns.json`

    - `jq '.[0].Vulnerabilities[] | select(.Description | test("privilege escalation"))'wp_all_vulns.json > wp_pe_vulns.json`

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.    

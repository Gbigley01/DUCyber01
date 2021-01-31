## Activity File: Container Vulnerability Analysis with Trivy and Bash

In this activity, you will play the role of a web app security engineer as part of the company's Systems Engineer and Developer team.

- The developers at your company insist on using the following Docker image for the general microservice architecture planned by your company's systems architect: `wordpress:4.6.1-php5.6-apache`. Your systems engineer, however insists that using such an old Docker image of WordPress presents a significant security risk.

- You are tasked with using Trivy to scan the `wordpress:4.6.1-php5.6-apache` image on WordPress's official Docker Hub, generate a comprehensive list of the most severe vulnerabilities, and report your findings to the Risk Management team.

### Trivy Installation

Before you begin, you will need to install Trivy. Run the following as `sudo`:

- Log onto the terminal environment and run the command `sudo wget tinyurl.com/14-2--setup`.
- Make the downloaded file executable: `sudo chmod +x 14-2--setup`.
- Run the script `sudo ./14-2--setup`.

**Note**: During the activity, you may encounter Trivy Go runtime errors. If you do, the database is likely corrupted and can be resolved by running the following command:

- `trivy --reset` 

The `--reset` option removes all caches and database if it errors out at any point. This can happen if you Ctrl+C before the vulnerability scan is finished.

Read more about this:

- [Aqua Security: Trivy --reset](https://github.com/aquasecurity/trivy#reset)
- [Aqua Security: Crash following interrupted DB download](https://github.com/aquasecurity/trivy/issues/288)

### Instructions

1. Create a `trivy_reports` directory in your user `Documents` directory.

2. Use Trivy to create a vulnerability log named `wp_all_vulns.json` containing all high and critical vulnerabilities from the `wordpress:4.6.1-php5.6-apache` Docker image. 

3. Use `jq` to show all of the vulnerabilities by running: `jq . wp_all_vulns.json`.  

4. Using the `jq` `select()` and `test()` filters, edit the `jq` command to filter the following vulnerability types into a new JSON file:

    - Buffer overflow 
    - Denial of service 
    - Privilege escalation

    Replace the placeholders in the command below:
   - `jq '.[0].Vulnerabilities[] | select(.Description | test("[vulnerability type]"))' wp_all_vulns.json > wp_[vulnerability_acronym]_vulns.json`

    - Don't forget to include parentheses around the filters and double quotes around the strings. Also, the `test` filter should be within the `select` filter.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  
  





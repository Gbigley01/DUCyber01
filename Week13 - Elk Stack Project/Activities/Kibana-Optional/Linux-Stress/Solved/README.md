#### Linux Stress Optional Activity Solutions

#### Instructions

The Metrics page for a single VM shows the CPU usage for that machine. This provides insight into how much work the machine is doing. Excessively high CPU usage is typically a cause for concern, as overworked computers are at greater risk for failure.

Metricbeat forwards data about CPU load to Elastic Search, and this data can be visaulized with Kibana.

In this activity, you will intentionally stress the CPU of one of your VMs, then find evidence of the increased activity in Kibana.

Linux has a common, easy-to-use diagnostic program called `stress`. It is easy to use and can be downloaded via `apt`.

**Solutions:**

**Using Stress:**

From your Jump-Box, start up your `Ansible` container and attach to it.

```bash
$ sudo docker container list a #to obtain the container name

$ sudo docker start container_name

$ sudo docker attach container_name
```

SSH from your Ansible container to one of your WebVM's.

```bash
$ ssh username@ip.of.web.vm
```

Run `sudo apt install stress` to install the stress program.

Run `sudo stress --cpu 1` and allow stress to run for a few minutes. 

View the Metrics page for that VM in Kibana. 

Are you able to see the CPU usage increase?

**Answer:** Yes. Leave the stress test running and continue to refresh the kibana metrics page for that VM. You should see a jump n CPU usage similar to the below:

![](../../../../Images/metrics-kibana/CPU-Spike.png)

**Your Task:**

- Run the `stress` program on all 3 of your VM's and take screen shots of the data generated on the metrics page of Kibana.

**Solution:** you should be able to create screen shots similar to the below:

![](../../../../Images/metrics-kibana/VM-cpu-1.png)

![](../../../../Images/metrics-kibana/VM-CPU-2.png)

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved. 
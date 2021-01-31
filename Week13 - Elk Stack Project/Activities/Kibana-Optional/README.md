### Optional Kibana Activities

The main goal of this project was to _create the infrastructure_ behind a SIEM like Kibanna. If you have completed the setup, you are finished with the project. If you have not completed the optional `Metricbeat` configuration, those steps will need to be completed before this activity can be completed. 

Because this project was focused on IaC, using Kibana, visualizing data and creating alerts are all outside of the scope of this project, however, we _will_ dive into creating alerts and dashboards in the SIEM week using Splunk (another SIEM). 

Note also that these activities comprise different job roles. Getting the infrastructure setup and maintaining it is the role of a security engineer or cloud architect. _Using that infrastructure_, creating dashboards and alerts fall under the security analyst role. It would be rare to have a position where you would be required to do both.

That said, now that we have Kibana setup and gathering data from 3 web servers, you may want to get a feel for how to visualize data in Kibana.

### Kibana Metrics and Logs Orientation (Optional Demo or Student Readme)

Before we begin generating traffic, locate the two screens inside Kibana that you will use to visualize this traffic:
- Metrics
- Logs

![](../../Images/metrics-kibana/Metrics-Logs.png)

These pages will show you the changes in data that we will create.

**LOGS:**

Click on logs to see some general system logs coming from the web machines.

![](../../Images/metrics-kibana/Logs-General.png)

Notice that you can Stream logs live from the machines. 

![](../../Images/metrics-kibana/Stream-Live.png)

**METRICS:**

Next, click on 'Metrics' on the left side. 

Here we can see each of our VM's that are sending back metrics.

Click on one of the large squares that represent one of your VM's.

Choose 'View metrics' from the dropdown that appears.

![](../../Images/metrics-kibana/Metric-VM-Dropdown.png)

Notice that you can see CPU and Memory usage here.

![](../../Images/metrics-kibana/Host-Overview.png)

Now that we know where to look for this data, let's generate some unusual network traffic.

#### Instructions

These activities will guide you though generating some data to visualize in Kibana.

To complete these activities, we will:
1. Use our jump-box to attack our web machines in various ways.
2. Use a linux utility to stress the system of a webVM directly. 
3. Subsequently generate traffic and logs that Kibana will collect.
4. View that traffic in various ways inside Kibanna.
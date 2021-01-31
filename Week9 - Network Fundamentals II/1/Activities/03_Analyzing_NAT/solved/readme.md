## Solution Guide: Analyzing NAT

In the exercise, you analyzed several network routes and added these routes to a network address translation table based on internal and external IP addresses.

Completing this activity required the following steps:

- Reviewing Acme's list of network traffic routes.

- Adding the routes to the provided network address translation table.
   
---

The completed NAT chart should have private addresses in the LAN column, and public addresses in the WAN column:

	            NAT TRANSLATION TABLE	
		
      WAN SIDE ADDRESS		    LAN SIDE ADDRESS
      74.121.231.31:80		    10.0.0.22:5000
      204.79.197.200:80		    10.0.0.43:6000
      224.85.197.200:80		    10.0.0.67:5000
      224.85.197.200:443      10.0.0.34:5000
      226.198.36.39:80		    192.168.32.0:80



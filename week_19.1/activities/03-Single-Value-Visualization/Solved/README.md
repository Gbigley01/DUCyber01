## Solution Guide:  Single Value Visualizations
      
In this activity, you were tasked with designing a radial gauge to illustrate the severity of a single value.

--- 

1.  Design a search to view the POST events:

    - `source="radialgauge.csv" http_method=POST |stats  count as total`
   

2. Design a radial gauge to visualize the data. 
  
    - Select **Visualization** > **Radial Gauge**.

    - Change the ranges of the radial gauge by selecting **Format** > **Color Ranges** > **Manual**.

      The ranges can vary, as long as 1,200 POST requests per hour is in the red range.

      - For example:
        - Green: 0-400
        - Yellow: 400-1,000
        - Red: 1,000-2,000

3. Save your visualization as "Radial Gauge - POST request monitor."   

Once you save, the radial gauge should display.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  

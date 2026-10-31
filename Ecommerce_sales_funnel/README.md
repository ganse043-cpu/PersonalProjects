E-commerce Sales Funnel Analysis
Otto Ganser | MySQL · Tableau Public

Analyzed e-commerce user events to compare funnel participation, traffic-source conversion rates, and revenue. Built a Tableau dashboard to communicate findings and identify areas for further investigation.

Tableau dashboard: Add your published dashboard URL here.
Dataset source: Add the dataset name, source URL, and whether it is real or simulated.
Date range: Add the earliest and latest event dates.
Dashboard

The dashboard includes a revenue overview, user counts across five funnel stages, overall stage ratios, and view-to-cart and view-to-purchase rates by traffic source.
Business Questions
- Where is the largest decrease in user counts across the purchasing stages?
- Which traffic sources have the highest and lowest conversion rates?
- How much revenue did purchases generate, and what was the average order value?
Key Findings
- The largest decrease in stage counts occurs between page views and cart activity: 5,000 users recorded page views, compared with 1,553 who added items to their carts.
- Email leads the traffic-source comparison: its view-to-cart rate is 62.45% and its view-to-purchase rate is 33.91%.
- Social has the lowest rates: 13.59% for view to cart and 6.93% for view to purchase. Email's purchase rate is approximately 4.9 times social's.
- Purchase events generated $87,975.11 in revenue across 826 orders, with an average order value of $106.51 and revenue per page-view user of $17.60.
Funnel Participation
Stage	Distinct Users
Page view	5,000
Add to cart	1,553
Checkout start	1,103
Payment information	899
Purchase	826


Overall stage ratios use these independently counted user totals. The purchase-to-view ratio is 16.52%; the view-to-cart ratio is 31.06%.
Traffic-Source Results
Traffic Source	Page View Users	Purchasers at or After View	View-to-Cart Rate	View-to-Purchase Rate
Email	522	177	62.45%	33.91%
Paid Ads	968	204	36.98%	21.07%
Organic	2,038	343	32.83%	16.83%
Social Media	1,472	102	13.59%	6.93%


Organic has the largest purchaser count, while email has the highest purchase rate.
Recommendations
- Investigate product pages and the shopping experience to identify potential improvements to cart engagement.
- Examine social traffic quality and landing pages to understand the lower conversion rates.
- Test expanding email marketing and measure whether conversion performance holds for a broader audience.
- Collect channel costs and revenue by source before recommending changes to marketing budgets.
Technical Approach
MySQL
- Used CTEs and conditional aggregation to calculate distinct-user stage counts.
- Joined users' first page views by source to subsequent cart and purchase events.
- Used NULLIF to protect division calculations and ROUND for two-decimal reporting.
- Calculated revenue, order value, revenue per buyer, and revenue per visitor.
- Retained a time-to-conversion query as additional analysis outside the current dashboard.
Tableau Public
- Imported SQL result summaries through CSV files.
- Built bar charts for stage counts and conversion comparisons.
- Created a revenue summary and added findings and recommendations to the dashboard.
Metric Definitions and Scope
- Overall stage ratios: Distinct users at one event stage divided by distinct users at the preceding stage; overall purchase-to-view ratio uses purchasers divided by page-view users. These counts do not verify that the same users completed all stages in order.
- Source view-to-cart / view-to-purchase rates: Among users with a page view from a source, the percentage with a cart or purchase event recorded at or after their first view from that source.
- Attribution: Later events can have any traffic source. A user who viewed through multiple sources may count as a converter for each. No fixed conversion window is applied, and a purchase does not require a preceding cart event.
- Revenue: Sum of purchase-event amounts. Each purchase event is assumed to represent one order. Revenue per visitor divides revenue by distinct page-view users.
- Timing analysis: Uses the earliest timestamp for each event independently. Missing events and event ordering require review before interpreting the averages.
Rates are exported on a 0–100 scale: 33.91 represents 33.91%. CSV summaries are static and do not support shared filters that recalculate all metrics. Channel comparisons are observational and do not establish causation or profitability.
Repository Files
Suggested filenames below should be matched to the files uploaded to this repository.
File	Description
funnel_analysis.sql	Cleaned SQL queries for funnel stages, rates, source conversion, revenue, and conversion timing
dashboard.png	Dashboard image shown above
sales_funnel.twbx	Packaged Tableau workbook
data/	Source data and exported summaries, where sharing is permitted


Reproduce the Analysis
1. Obtain the dataset from the source listed above.
2. Create a MySQL database named users and import the dataset into user_events.
3. Confirm the required columns: user_id, event_type, event_date, traffic_source, and amount.
4. Run funnel_analysis.sql and export the result sets to CSV.
5. Open the Tableau workbook and reconnect its data sources to the exported files as needed.
6. Refresh the worksheets and check that their values match the SQL output.
Future Improvements
- Validate a complete sequential purchasing funnel.
- Add a defined conversion window and explicit attribution model.
- Use event-level data to support date and traffic-source filters.
- Analyze acquisition cost, revenue by source, and marketing return.
Author
Otto Ganser — LinkedIn

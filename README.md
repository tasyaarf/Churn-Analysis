# Customer Churn Analysis  ( SQL & Power BI Project)

### Table Of Content
- [Business Request](#business-request)
- [Data Source](#data-source)
- [Data Cleansing and Transformation](#data-cleansing-and-transformation)
- [Data Analysis](#data-analysis)
- [Churn Analysis Dashboard](#churn-analysis-dashboard)

### Business Request
This business case focused on churn analysis of telecom firm. According to the business request, the following user stories were established to meet  goals and ensure that acceptance criteria were consistently met throughout the project.

|As a (role)| I want (request/demand) | So that (user value) | Acceptance Criteria |
|-----------|-------------------------|----------------------|---------------------|
|Sales Manager| To get a dashboard overview of total customer, new joiners, churned customer |Can analyze the churn rate and improve the performance| A Power BI dashboard which visualize the number of customer by status (new joiners and churned)|
|Sales Manager| To get insight on demographic aspect, whether total churn differs significantly  between gender|Can analyze performance based on gender variations|A power BI dashboard which compare total churn between male and female|
|Sales Manager|To get insight on demographic aspect, whether churn rate differs significantly between age group| Can analyze which group have the highest and lowest churn rate |A Power BI dashboard which visualize total churn based on age group and incorporate it with churn rate percentage line|
|Sales Manager|To get overview of churn rate based on account info (payment method, contract duration, and tenure |Can analyze the customer behavior,  which factor led to lower churn rate | A power BI dashboard that  visualize churn rate by payment method, contract and tenure group|
|Sales Manager| To get insight whether total churn affect significantly to revenue gained |Can analyze the financial performance whether it reach the target |A power BI dashboard which compare revenue before and after customer churned and the percentage of reduction|
|Sales Representative|To get detail overview of churn rate per state |Can track region which has higher churn rate and identify opportunities to increase customer retention|A Power BI dashboard which allows me to know churn rate information for each state|
|Sales Representative| To get insight on why customer churn |Can track which factor significantly affect the churn rate and identify opportunities to improve|A Power BI dashboard which allows me to know churn rate for each churn category|
|Sales Representative|To get detail overview of churn rate based on internet type| I can quickly know the best performing internet type |A Power BI dashboard which visualize the churn rate by internet type|
|Sales Representative|To get detail overview of total churn based on services | I can quickly know which service significantly enhance customer retention|A Power BI dashboard which visualize the total churn by services|

### Data Source
The primary dataset used for this analysis is the "coffee_shop_sales.csv" file, containing detailed information about each sale made by the coffee shop.

### Data Cleansing and Transformation 
The process includes:
   1. Data loading and inspection regarding missing values, the appropriate data type in each column 
   2. Develop clean data by eliminating duplicated and unstructured data

by means of that process, the cleaned data can be seen on ["Coffee_Shop_Analysis_SQL_Script"](https://github.com/tasyaarf/SQL-PowerBI-Project-Coffee-Shop-Analysis-/blob/8c1061b5976be06e4e6eea79e04714ede5192233/Coffe_Shop_Analysis_SQL_Script.sql) files
 

### Data Analysis 
To fulfill the business request and user needs the file of SQL script can be seen on ["Coffee_Shop_Analysis_SQL_Script"](https://github.com/tasyaarf/SQL-PowerBI-Project-Coffee-Shop-Analysis-/blob/8c1061b5976be06e4e6eea79e04714ede5192233/Coffe_Shop_Analysis_SQL_Script.sql) files


### Churn Analysis Dashboard

The churn analysis dashboard contain the overview churn analysis which can be track based on demographic aspect, account info, services and oversee the financial performance as well.
the dashbord can be downloaded on ["Churn Analysis Report"](https://github.com/tasyaarf/SQL-PowerBI-Project-Coffee-Shop-Analysis-/blob/084dc6180bfadbd8a20ba100be5b6ae81cfaf704/coffee_sales_report.pbix) files 


## References
- http://www.youtube.com/@datatutorials1



Amazon Orders Dataset — Data Analytics Final Project
A comprehensive end-to-end Data Analytics project analyzing 1,13,698 Amazon Orders records using four industry-standard tools — Python, Microsoft Excel, MySQL Workbench, and Microsoft Power BI.

Project Overview
This project was completed as part of the Data Analytics Program at Agileology Institute (November 2025 – April 2026). The objective was to perform a full data analytics workflow — from raw data cleaning to interactive dashboard creation — on a real-world Amazon Orders dataset covering Pan-India e-commerce transactions from January 2022 to September 2022.

Dataset Summary
AttributeDetailsDataset NameAmazon Orders DatasetRaw Records1,28,975 rowsCleaned Records1,13,698 rowsTotal Columns29 columnsTime PeriodJanuary 2022 to September 2022GeographyPan-IndiaCategoriesKurta, Set, Western Dress, Top, Ethnic Dress, Blouse, Bottom, Saree, Dupatta

Tools Used
ToolVersionPurposePython3.xData Cleaning, EDA, VisualizationPandasLatestData manipulationMatplotlib & SeabornLatestEDA ChartsMicrosoft Excel2019/365Pivot Tables, Charts, DashboardMySQL Workbench8.0SQL Queries and AnalysisMicrosoft Power BIDesktopInteractive 5-Page Dashboard

Repository Structure
Amazon-Orders-Data-Analytics-Project/
│
├── DATA ANALYSIS PROJECT - AMAZON ORDERS DATASET.pdf
├── Amazon_dataset.csv - [Drive_Link](https://drive.google.com/file/d/1XKcuZg3KVDQ2KP9NKYCzahcnyBH9MgK4/view?usp=drive_link)
├── Data_Cleaning.py
├── Cleaned_Amazon_Dataset_Final.csv - [Drive_Link](https://drive.google.com/file/d/1NAY4w3HumScnpMb_6pdt0JhC1x-DID5Q/view?usp=drive_link)
├── Amazon_Data_Py_Plots/
│   ├── category_distribution.png
│   ├── size_distribution.png
│   ├── status_distribution.png
│   ├── top_cities.png
│   ├── top_states.png
│   └── size_category_heatmap.png
├── Amazon_Analysis.xlsx - [Drive_Link](https://docs.google.com/spreadsheets/d/1jrrbaiwJYr7FNv_S-0AY-7h2H8k4_N9M/edit?usp=drive_link&ouid=111056330319864691380&rtpof=true&sd=true)
├── Amazon_Queries.sql
├── Amazon_data_SQL_Queries_Outputs/
│   ├── Query_01_Total_Orders.png
│   ├── Query_02_Data_Preview.png
│   ├── Query_03_Unique_Values.png
│   ├── Query_04_Orders_By_Category.png
│   ├── Query_05_Top5_States_Revenue.png
│   ├── Query_06_Top5_Cities_Revenue.png
│   ├── Query_07_Orders_By_State.png
│   ├── Query_08_Orders_By_City.png
│   ├── Query_09_Courier_Status.png
│   ├── Query_10_Monthly_Revenue.png
│   ├── Query_11_Fulfilment_Revenue.png
│   ├── Query_12_Ship_Service_Revenue.png
│   ├── Query_13_Qty_vs_Amount.png
│   ├── Query_14_Cancellation_Category.png
│   ├── Query_15_Cancellation_Size.png
│   ├── Query_16_Promotion_Revenue.png
│   ├── Query_17_ShipService_Category.png
│   ├── Query_18_Top10_SKUs.png
│   ├── Query_19_B2B_vs_B2C.png
│   └── Query_20_Overall_KPI_Summary.png
├── Amazon_dataset_PB.pbix
├── Amazon_dataset_Dashboard.pdf
├── Amazon_Insights_Strategy_Report.pdf
└── Data_Analytics_Project_Documentation_Presentation.pptx

Project Phases
Phase 1 — Python: Data Cleaning and EDA
File: Data_Cleaning.py
Output: Cleaned_Amazon_Dataset_Final.csv
Tasks Completed:

Loaded raw dataset of 1,28,975 rows and 24 columns
Dropped junk columns — index, Unnamed 22, fulfilled-by
Handled missing values in Courier Status, promotion-ids, ship-city, ship-state
Dropped rows with null Amount and currency values
Standardized all text columns — Title Case, stripped spaces
Fixed data types — Date to datetime64, Amount to float, Qty to integer
Flagged outliers in Amount column using IQR method
Created 6 derived columns — Order_Month, Order_Month_Name, Order_Year, Order_Week, Order_Day, Revenue_Band
Generated 6 EDA charts saved as PNG files
Exported final cleaned dataset — 1,13,698 rows, 29 columns

EDA Charts Generated:

Category Distribution Bar Chart
Size Distribution Bar Chart
Order Status Distribution Bar Chart
Top 10 Cities by Orders Bar Chart
Top 10 States by Orders Bar Chart
Product Size vs Category Heatmap


Phase 2 — Excel: Pivot Tables and Dashboard
File: Amazon_Analysis.xlsx
Tasks Completed:

Imported Cleaned_Amazon_Dataset_Final.csv into Excel
Converted data to structured Excel Table named AmazonOrders
Built 8 Pivot Tables with corresponding Charts
Created KPI Dashboard with 6 direct formula cards

Pivot Tables Built:

Orders by Product Category — Bar Chart
Orders by Product Size — Pie Chart
Order Status Distribution with Percentage — Donut Chart
Top 5 States by Revenue — Column Chart
Top 5 Cities by Revenue — Bar Chart
Monthly Revenue Trend — Line Chart
Category vs Size Cross Analysis — Stacked Bar Chart
Revenue by Fulfilment Channel — Column Chart

KPI Cards on Dashboard:

Total Orders — COUNTA formula
Total Revenue — SUM formula
Average Order Value — AVERAGE formula
Total Qty Sold — SUM formula
Total Cancelled Orders — COUNTIF formula
Total Shipped Orders — COUNTIF formula


Phase 3 — SQL: Business Analysis Queries
File: Amazon_Queries.sql
Output Screenshots: Amazon_data_SQL_Queries_Outputs folder
Database: amazon_project
Table: amazon_orders
Tool: MySQL Workbench 8.0
Total Queries: 20
Query Sections:
Section 1 — Basic Exploration (Queries 1 to 3)

Total records count
Data preview
Unique values in key columns

Section 2 — Orders Based Analysis (Queries 4 to 9)

Orders by product category
Top 5 states by total revenue
Top 5 cities by total revenue
Orders by ship state
Orders by ship city
Orders by courier status

Section 3 — Revenue Based Analysis (Queries 10 to 13)

Monthly revenue trend
Revenue by fulfilment channel
Revenue by ship service level
Quantity vs amount by category

Section 4 — General Analysis (Queries 14 to 20)

Cancellation rate by category
Cancellation rate by size
Promotion vs no promotion revenue
Ship service vs product category
Top 10 SKUs by revenue
B2B vs B2C orders
Overall KPI summary


Phase 4 — Power BI: Interactive Dashboard
File: Amazon_dataset_PB.pbix
Exported PDF: Amazon_dataset_Dashboard.pdf
DAX Measures Created:

Total Orders = COUNTROWS(AmazonOrders)
Total Revenue = SUM(AmazonOrders[Amount])
Avg Order Value = AVERAGE(AmazonOrders[Amount])
Total Qty Sold = SUM(AmazonOrders[Qty])
Cancelled Orders = CALCULATE(COUNTROWS(AmazonOrders), AmazonOrders[Status] = "Cancelled")
Cancellation Rate % = DIVIDE([Cancelled Orders], [Total Orders]) * 100

Dashboard Pages:

Overview — 6 KPI Cards, Orders by Status, Orders by Category, Top 10 Cities, B2B vs B2C
Orders Based Insights — Top 5 States, Top 5 Cities, Courier Status, Monthly Orders, Orders by Size, Ship Service
Revenue Insights — Monthly Revenue Trend, Top 5 States Revenue, Top 5 Cities Revenue, Fulfilment Revenue, Ship Service Revenue, Revenue by Category
General Insights — Cancellation Rate by Category, Cancellation Rate by Size, Promotion vs Revenue, Ship Service by Category, B2B vs B2C Revenue, Revenue Band Distribution
Orders Explorer — 3 Interactive Slicers, Detailed Orders Table with 11 columns

Theme: Dark Navy Professional
Canvas Background: #1B2A4A

Key Results and Findings
KPI Summary
KPIValueTotal Orders1,13,698Total RevenueINR 75 Million+Average Order ValueINR 663Total Qty Sold1,14,136Cancellation Rate4.95%Fulfilment Rate91%+
Top Categories
CategoryOrdersShareKurta44,000+38.76%Set44,000+38.61%Western Dress14,000+12.04%Top10,000+8.52%
Top 5 States by Revenue
StateRevenueMaharashtraINR 12.9 MillionKarnatakaINR 10.2 MillionTelanganaINR 6.6 MillionUttar PradeshINR 6.5 MillionTamil NaduINR 6.2 Million
Top 5 Cities by Revenue
CityRevenueBengaluruINR 7.1 MillionHyderabadINR 5.4 MillionMumbaiINR 4.2 MillionNew DelhiINR 3.8 MillionChennaiINR 3.5 Million
Revenue Peak Months
MonthRevenueReasonSeptemberINR 19.6 MillionIndian Festive Season — Navratri, Durga Puja, DussehraMayINR 17.1 MillionSummer Fashion Buying Season
Key Business Insights

Kurta and Set together account for 77% of all orders
Top sizes M, L, XL, XXL cover approximately 70% of all order volume
Promoted orders generate 2.5x more revenue than non-promoted orders
Expedited shipping accounts for 74% of total revenue — INR 17.8 Million
Amazon FBA fulfils majority of orders — preferred by customers
September and May are the two critical selling windows for sellers
Maharashtra and Karnataka are the highest revenue states
Bengaluru is the single highest revenue city at INR 7.1 Million
B2C orders make up 99.27% of total orders — pure retail business
Overall cancellation rate of 4.95% needs monitoring


Project Documentation
DocumentDescriptionAmazon_Insights_Strategy_Report.pdf2-page insights report with observations, trends, strategies, and new seller recommendationsData_Analytics_Project_Documentation_Presentation.pptx10-slide professional presentation covering all project highlights

How to Run the Python File
Step 1 — Install required libraries
pip install pandas numpy matplotlib seaborn
Step 2 — Place Amazon_dataset.csv in the same folder as Data_Cleaning.py
Step 3 — Run the script
python Data_Cleaning.py
Step 4 — Output files generated

Cleaned_Amazon_Dataset_Final.csv
category_distribution.png
size_distribution.png
status_distribution.png
top_cities.png
top_states.png
size_category_heatmap.png


How to Run the SQL File
Step 1 — Open MySQL Workbench
Step 2 — Create a new database
CREATE DATABASE amazon_project;
USE amazon_project;
Step 3 — Run the CREATE TABLE statement from Amazon_Queries.sql
Step 4 — Import Cleaned_Amazon_Dataset_Final.csv using Table Data Import Wizard
Step 5 — Run each query one by one using Ctrl + Enter

How to Open the Power BI Dashboard
Step 1 — Download and install Microsoft Power BI Desktop (free)
https://powerbi.microsoft.com/downloads/
Step 2 — Open Amazon_dataset_PB.pbix in Power BI Desktop
Step 3 — If data source error appears, update the CSV path:
Home tab — Transform Data — Data Source Settings — Change Source — browse to Cleaned_Amazon_Dataset_Final.csv
Step 4 — Click Refresh to reload data
Step 5 — Navigate through all 5 dashboard pages using the page tabs at the bottom

Connect with Me
LinkedIn — https://linkedin.com/in/swaroopkumarvathada
GitHub — https://github.com/swaroop456
Email — swaroop.vathada@gmail.com

About This Project
This project was completed as the Final Capstone Project of the Data Analytics Program at Agileology Institute. It demonstrates end-to-end proficiency in the complete data analytics workflow — data cleaning, exploratory analysis, SQL querying, and interactive dashboard creation — using four industry-standard tools across a real-world e-commerce dataset of over 1 lakh records.

Prepared by Swaroop Kumar Vathada
Data Analytics Program — Agileology Institute
November 2025 to April 2026

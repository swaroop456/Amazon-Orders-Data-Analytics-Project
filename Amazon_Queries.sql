-- ================================================
-- AMAZON ORDERS DATASET - SQL ANALYSIS
-- Student: Swaroop Kumar Vathada
-- Tool: MySQL Workbench
-- Database: amazon_project
-- ================================================
-- Creating a database with name amazon_project
CREATE DATABASE amazon_project; 

-- Using amazon_project database
USE amazon_project;

-- Creating a table with name amazon_orders with respective dataset Columns
CREATE TABLE amazon_orders (
    Order_ID VARCHAR(50),
    Date DATE,
    Status VARCHAR(100),
    Fulfilment VARCHAR(50),
    Sales_Channel VARCHAR(50),
    Ship_Service_Level VARCHAR(50),
    Style VARCHAR(50),
    SKU VARCHAR(100),
    Category VARCHAR(50),
    Size VARCHAR(20),
    ASIN VARCHAR(50),
    Courier_Status VARCHAR(50),
    Qty INT,
    Currency VARCHAR(10),
    Amount DECIMAL(10,2),
    Ship_City VARCHAR(100),
    Ship_State VARCHAR(100),
    Ship_Postal_Code VARCHAR(20),
    Ship_Country VARCHAR(50),
    Promotion_IDs TEXT,
    B2B VARCHAR(5),
    Promotion_Type VARCHAR(50),
    Revenue_Band VARCHAR(20),
    Order_Month INT,
    Order_Month_Name VARCHAR(20),
    Order_Year INT,
    Order_Week INT,
    Order_Day VARCHAR(20),
    Amount_Outlier_Flag VARCHAR(10)
);

-- Loading the Cleaned_Amazon_dataset
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cleaned_Amazon_Dataset.csv'
INTO TABLE amazon_orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Finding where MySQL allows file imports:
SHOW VARIABLES LIKE 'secure_file_priv';

-- ================================================
-- SECTION 1: BASIC EXPLORATION
-- ================================================

-- Query 1: Total Number of Orders
-- Purpose: Confirm how many records are loaded correctly
SELECT COUNT(*) AS Total_Orders
FROM amazon_orders;

-- ------------------------------------------------

-- Query 2: Preview First 10 Rows
-- Purpose: Visually verify data looks clean after import
SELECT *
FROM amazon_orders
LIMIT 10;

-- ------------------------------------------------

-- Query 3: Unique Values in Key Columns
-- Purpose: Understand variety of data in important columns
SELECT 
    COUNT(DISTINCT Category) AS Unique_Categories,
    COUNT(DISTINCT Size) AS Unique_Sizes,
    COUNT(DISTINCT Status) AS Unique_Statuses,
    COUNT(DISTINCT Ship_State) AS Unique_States,
    COUNT(DISTINCT Ship_City) AS Unique_Cities
FROM amazon_orders;

-- ================================================
-- SECTION 2: ORDERS BASED ANALYSIS
-- ================================================

-- Query 4: Orders by Product Category
-- Purpose: Find which category receives most orders
SELECT 
    Category,
    COUNT(*) AS Total_Orders
FROM amazon_orders
GROUP BY Category
ORDER BY Total_Orders DESC;

-- ------------------------------------------------

-- Query 5: Top 5 States by Total Revenue
-- Purpose: Identify which states generate maximum sales amount
SELECT 
    Ship_State,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Amount), 2) AS Total_Revenue
FROM amazon_orders
GROUP BY Ship_State
ORDER BY Total_Revenue DESC
LIMIT 5;

-- ------------------------------------------------

-- Query 6: Top 5 Cities by Total Revenue
-- Purpose: Identify which cities generate maximum sales amount
SELECT 
    Ship_City,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Amount), 2) AS Total_Revenue
FROM amazon_orders
GROUP BY Ship_City
ORDER BY Total_Revenue DESC
LIMIT 5;

-- ------------------------------------------------

-- Query 7: Orders by Ship State
-- Purpose: Count total orders from each state
SELECT 
    Ship_State,
    COUNT(*) AS Total_Orders
FROM amazon_orders
GROUP BY Ship_State
ORDER BY Total_Orders DESC;

-- ------------------------------------------------

-- Query 8: Orders by Ship City
-- Purpose: Count total orders from each city
SELECT 
    Ship_City,
    COUNT(*) AS Total_Orders
FROM amazon_orders
GROUP BY Ship_City
ORDER BY Total_Orders DESC;

-- ------------------------------------------------

-- Query 9: Orders by Courier Status
-- Purpose: See how many orders were delivered, returned etc
SELECT 
    Courier_Status,
    COUNT(*) AS Total_Orders,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM amazon_orders), 2) AS Percentage
FROM amazon_orders
GROUP BY Courier_Status
ORDER BY Total_Orders DESC;

-- ================================================
-- SECTION 3: REVENUE BASED ANALYSIS
-- ================================================

-- Query 10: Monthly Revenue Trend
-- Purpose: Understand how revenue changes month by month
SELECT 
    Order_Year,
    Order_Month,
    Order_Month_Name,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Amount), 2) AS Total_Revenue,
    ROUND(AVG(Amount), 2) AS Avg_Order_Value
FROM amazon_orders
GROUP BY Order_Year, Order_Month, Order_Month_Name
ORDER BY Order_Year, Order_Month;

-- ------------------------------------------------

-- Query 11: Revenue by Fulfilment Channel
-- Purpose: Compare Amazon fulfilled vs Merchant fulfilled revenue
SELECT 
    Fulfilment,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Amount), 2) AS Total_Revenue,
    ROUND(AVG(Amount), 2) AS Avg_Order_Value
FROM amazon_orders
GROUP BY Fulfilment
ORDER BY Total_Revenue DESC;

-- ------------------------------------------------

-- Query 12: Revenue by Ship Service Level
-- Purpose: Check if expedited shipping brings higher value orders
SELECT 
    Ship_Service_Level,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Amount), 2) AS Total_Revenue,
    ROUND(AVG(Amount), 2) AS Avg_Order_Value
FROM amazon_orders
GROUP BY Ship_Service_Level
ORDER BY Total_Revenue DESC;

-- ------------------------------------------------

-- Query 13: Quantity vs Amount by Category
-- Purpose: Understand relation between qty sold and revenue per category
SELECT 
    Category,
    SUM(Qty) AS Total_Qty_Sold,
    ROUND(SUM(Amount), 2) AS Total_Revenue,
    ROUND(AVG(Amount), 2) AS Avg_Order_Value
FROM amazon_orders
GROUP BY Category
ORDER BY Total_Revenue DESC;

-- ================================================
-- SECTION 4: GENERAL ANALYSIS
-- ================================================

-- Query 14: Cancellation Rate by Category
-- Purpose: Find which categories have highest cancellation
SELECT 
    Category,
    COUNT(*) AS Total_Orders,
    SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled_Orders,
    ROUND(SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Cancellation_Rate_Percent
FROM amazon_orders
GROUP BY Category
ORDER BY Cancellation_Rate_Percent DESC;

-- ------------------------------------------------

-- Query 15: Cancellation Rate by Size
-- Purpose: Find which sizes have highest cancellation rate
SELECT 
    Size,
    COUNT(*) AS Total_Orders,
    SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled_Orders,
    ROUND(SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Cancellation_Rate_Percent
FROM amazon_orders
GROUP BY Size
ORDER BY Cancellation_Rate_Percent DESC;

-- ------------------------------------------------

-- Query 16: Promotion vs No Promotion Revenue
-- Purpose: Check if promotions actually drive more revenue
SELECT 
    Promotion_Type,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Amount), 2) AS Total_Revenue,
    ROUND(AVG(Amount), 2) AS Avg_Order_Value
FROM amazon_orders
GROUP BY Promotion_Type
ORDER BY Total_Revenue DESC;

-- ------------------------------------------------

-- Query 17: Ship Service vs Product Category
-- Purpose: Find which categories prefer which shipping type
SELECT 
    Ship_Service_Level,
    Category,
    COUNT(*) AS Total_Orders
FROM amazon_orders
GROUP BY Ship_Service_Level, Category
ORDER BY Ship_Service_Level, Total_Orders DESC;

-- ------------------------------------------------

-- Query 18: Top 10 SKUs by Revenue
-- Purpose: Identify best performing individual products
SELECT 
    SKU,
    Category,
    COUNT(*) AS Total_Orders,
    SUM(Qty) AS Total_Qty_Sold,
    ROUND(SUM(Amount), 2) AS Total_Revenue
FROM amazon_orders
GROUP BY SKU, Category
ORDER BY Total_Revenue DESC
LIMIT 10;

-- ------------------------------------------------

-- Query 19: B2B vs B2C Orders
-- Purpose: Compare business orders vs individual customer orders
SELECT 
    B2B,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Amount), 2) AS Total_Revenue,
    ROUND(AVG(Amount), 2) AS Avg_Order_Value
FROM amazon_orders
GROUP BY B2B
ORDER BY Total_Revenue DESC;

-- ------------------------------------------------

-- Query 20: Overall KPI Summary
-- Purpose: Single view of all important business metrics
SELECT 
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Amount), 2) AS Total_Revenue,
    ROUND(AVG(Amount), 2) AS Avg_Order_Value,
    SUM(Qty) AS Total_Qty_Sold,
    SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS Total_Cancelled,
    ROUND(SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Overall_Cancellation_Rate
FROM amazon_orders;

-- ================================================
-- END OF SQL ANALYSIS
-- ================================================






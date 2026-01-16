CREATE DATABASE SuperstoreDW;
GO
USE SuperstoreDW;
GO

CREATE TABLE dbo.fact_Sales (
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Region VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(150),
    Sales DECIMAL(12,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(12,2)
);
INSERT INTO dbo.fact_Sales
SELECT
    Order_ID,
    TRY_CAST(Order_Date AS DATE),
    TRY_CAST(Ship_Date AS DATE),
    UPPER(Region),
    Category,
    Sub_Category,
    Product_Name,
    TRY_CAST(Sales AS DECIMAL(12,2)),
    TRY_CAST(Quantity AS INT),
    TRY_CAST(Discount AS DECIMAL(5,2)),
    TRY_CAST(Profit AS DECIMAL(12,2))
FROM dbo.stg_Superstore
WHERE Sales IS NOT NULL;
SELECT COUNT(*) AS CleanRows FROM fact_Sales;
SELECT 
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM fact_Sales;
CREATE INDEX idx_fact_sales_date ON fact_Sales(Order_Date);

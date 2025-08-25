-- Day 11/30 days 

/*
Problem: Find the Products with Sales on Consecutive Days
You are given a sales table with records of sales for each product. 

Write a query to find all products that were sold on consecutive days at least once. 
Return the ProductID and the first date in each pair of consecutive sales days.
*/

-- Create Sales Table
DROP TABLE IF EXISTS sales;
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    SaleDate DATE,
    Quantity INT
);

-- Insert records into Sales Table
INSERT INTO Sales (SaleID, ProductID, SaleDate, Quantity) VALUES
(1, 1, '2024-01-01', 100),  
(2, 1, '2024-01-02', 200), 
(3, 1, '2024-01-04', 150),  
(4, 2, '2024-01-03', 50),   
(5, 2, '2024-01-04', 75),   
(6, 3, '2024-01-05', 300), 
(7, 3, '2024-01-07', 250); 


  
WITH cte
AS
(
SELECT 
	s1.saleid,
	s1.productid,
	s1.saledate,
	s2.saledate as nxt_date
FROM sales as s1
JOIN 
sales s2
USING(productid)
) 
SELECT
	productid,
	MIN(saledate) AS sale_date
FROM cte
WHERE ABS(saledate - nxt_date) = 1
GROUP BY 1

------------------------------------------------------------------------------------------
OR
------------------------------------------------------------------------------------------

SELECT 
    ProductID,
    SaleDate AS FirstConsecutiveDate
FROM (
    SELECT 
        ProductID,
        SaleDate,
        LAG(SaleDate) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS PrevDate
    FROM Sales
) t

WHERE ABS(PrevDate - SaleDate) = 1

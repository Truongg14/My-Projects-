/*USE pizza_sales;

CREATE TABLE sales
(
	pizza_id int,
    order_id int,
    pizza_name_id varchar(50),
    quantity tinyint,
    order_date date,
    order_time time,
    unit_price float, 
    total_price float,
    pizza_size varchar(50),
    pizze_category varchar(50),
    pizza_ingredients varchar(200),
    pizza_name varchar(50)
);

DROP TABLE sales;

/* LOAD DATA INFILE 'Pizza Sales1.csv' INTO TABLE sales
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

SELECT * FROM sales;

(SELECT * FROM sales)
UNION 
(SELECT * FROM pizza_sales1);

SELECT * FROM sales;
*/

# Total Revenue
SELECT * FROM sales;
SELECT 
	ROUND(SUM(total_price),1) AS Total_Revenue 
FROM 
	sales;

# Average Order values
SELECT 
	ROUND(SUM(total_price) / COUNT(DISTINCT order_id),2) AS Average_Order_values 
FROM
	sales;
    
# Total Sold
SELECT
	SUM(quantity) AS Total_Sold
FROM 
	sales;
    
# Total Orders
SELECT
	COUNT(DISTINCT order_id) AS Total_Orders
FROM
	sales;
    
# Average P per order
SELECT
	CAST(SUM(quantity)/COUNT(DISTINCT order_id) AS DECIMAL(3,2)) AS Average_P_per_order
FROM 
	sales;
    
# Daily Trend for Total Orders
SELECT 
	DAYNAME(order_date) AS Order_Day,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM
	sales
GROUP BY DAYNAME(order_date);

# Hourly Trend for Total Orders
SELECT 
	CONCAT(HOUR(order_time), 'h') AS Order_Day,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM
	sales
GROUP BY CONCAT(HOUR(order_time), 'h');

# ALTER TABLE sales
# RENAME COLUMN pizze_category TO pizza_category;

# % of sales by Pizza Category
SELECT
	pizza_category,
    ROUND(SUM(total_price),2) AS Total_Sales,
	CONCAT(ROUND(SUM(unit_price*quantity) * 100/ (SELECT
		SUM(total_price)
	FROM 
		sales),2),'%') AS Percentage_Cate 
FROM
	sales 
GROUP BY pizza_category
ORDER BY Percentage_Cate DESC;

# % of sales by Pizza size
SELECT
	pizza_size,
    ROUND(SUM(total_price),2) AS Total_Sales,
	CONCAT(ROUND(SUM(unit_price*quantity) * 100/ (SELECT
		SUM(total_price)
	FROM 
		sales),2),'%') AS Percentage_Size
FROM
	sales 
GROUP BY pizza_size
ORDER BY Percentage_Size DESC;

# Total Pizzas Sold by Pizza Category
SELECT 
	pizza_category,
    SUM(quantity) AS Total_quantity
FROM
	sales
GROUP BY pizza_category;

# Top 3 best sellers of Total Pizza Sold
SELECT 
	pizza_name, 
    SUM(Quantity) AS Total_Sold
FROM 
	sales
GROUP BY Pizza_name
ORDER BY SUM(Quantity) DESC
LIMIT 3;

# Top 3 worst sellers of Total Pizza Sold
SELECT 
	pizza_name, 
    SUM(Quantity) AS Total_Sold
FROM 
	sales
GROUP BY Pizza_name
ORDER BY SUM(Quantity) ASC
LIMIT 3;

	



    










USE sales;
#
SELECT 
	o.order_id AS Order_id,
	CONCAT(c.first_name,' ', c.last_name) AS Full_Name,
    c.city AS City,
    c.state AS State,
    o.order_date AS Order_date,
    SUM(oi.quantity) AS 'Total Units',
    SUM(oi.quantity * oi.list_price) AS 'Total Revenue',
	pp.product_name AS Product_name,
    cp.category_name AS Category_name,
    sto.store_name AS Store_name,
    bp.brand_name,
    CONCAT(sta.first_name,' ', sta.last_name) AS 'Sales_pre',
    brand_name AS Brand_name
FROM
	orders o
		INNER JOIN
	customers c ON o.customer_id = c.customer_id
		INNER JOIN
	order_items oi ON o.order_id = oi.order_id
		INNER JOIN
	products_production pp ON oi.product_id = pp.product_id
		INNER JOIN
	categories_production cp ON pp.category_id = cp.category_id
		INNER JOIN
	stores sto ON o.store_id = sto.store_id
		INNER JOIN
	staffs sta ON o.staff_id = sta.staff_id
		INNER JOIN
	brands_production bp ON pp.brand_id = bp.brand_id
GROUP BY o.order_id,
		pp.product_name,
        category_name,
        store_name,
        brand_name
ORDER BY o.order_id ASC;


	
    
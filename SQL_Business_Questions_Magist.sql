USE Magist;

-- How many months of data are included in the magist database? -- The result is 25 months. 
    
SELECT
	COUNT(*) AS months_included_in_database
FROM
	(
    SELECT 
		DISTINCT(MONTH(order_purchase_timestamp)) AS month_in_year,
		YEAR(order_purchase_timestamp) AS years
	FROM orders
	ORDER BY
		years DESC,
		month_in_year DESC
	) total_months;    

-- ---------------------------------- 
-- ----------------------------------     






-- How many sellers are there? -- 3095 is the overall total of sellers on Magist.

SELECT COUNT(DISTINCT seller_id) AS total_sellers_magist
FROM sellers;

-- ---------------------------------- 
-- ---------------------------------- 






-- How many Tech sellers are there? -- 318 is the total of TECH sellers inside of Magist.

SELECT
	COUNT(DISTINCT seller_id) AS total_tech_sellers_magist
FROM order_items oi
INNER JOIN
	products p ON oi.product_id = p.product_id
INNER JOIN
	product_category_name_translation z ON p.product_category_name = z.product_category_name
WHERE
	product_category_name_english = 'computer_accessories'
    OR product_category_name_english = 'telephony'
	OR product_category_name_english = 'electronics'
    OR product_category_name_english = 'consoles_games'
    OR product_category_name_english = 'computers'
    OR product_category_name_english = 'tablets_printing_image'
    OR product_category_name_english = 'audio'
    OR product_category_name_english = 'cine_photo';
    		

-- What percentage of overall sellers are Tech sellers? ----> (318/3095)*100 = 10,2%

-- ---------------------------------- 
-- ---------------------------------- 






-- What is the total amount earned by all sellers? 
-- 59362.34 total_euros in 2016
-- 7239519.05 total_euros in 2017
-- 8699934.02 total_euros in 2018
-- TOTAL ALL YEARS ---> 15998815.41 euros

-- There has been an increment of 20,17% in sells on 2018 (up until October)

SELECT
	ROUND(SUM(payment_value),2) AS sum_total_payment_2017
FROM order_payments op
INNER JOIN
	orders o ON o.order_id = op.order_id
WHERE
	order_purchase_timestamp BETWEEN '2017-01-01' AND '2017-12-31';
    
SELECT
	ROUND(SUM(payment_value),2) AS sum_total_payment_2018
FROM order_payments op
INNER JOIN
	orders o ON o.order_id = op.order_id
WHERE
	order_purchase_timestamp BETWEEN '2018-01-01' AND '2018-12-31';
    
SELECT
	ROUND(SUM(payment_value),2) AS sum_total_payment_2016
FROM order_payments op
INNER JOIN
	orders o ON o.order_id = op.order_id
WHERE
	order_purchase_timestamp BETWEEN '2016-01-01' AND '2016-12-31';
    

-- ---------------------------------- 
-- ---------------------------------- 



  
  
  

-- What is the total amount earned by all Tech sellers?
-- TOTAL ALL YEARS IN TECH ---> 1231384.01 euros
-- 610587.48 total_euros in 2017
-- 683142.3 total_euros in 2018

SELECT
	ROUND(SUM(payment_value),2) AS sum_total_payment_tech_2017
FROM order_payments op
INNER JOIN
	orders o ON op.order_id = o.order_id
INNER JOIN
	order_items oi ON oi.order_id = op.order_id
INNER JOIN
	products p ON oi.product_id = p.product_id
INNER JOIN
	product_category_name_translation z ON p.product_category_name = z.product_category_name
WHERE
	(product_category_name_english = 'computer_accessories' OR
    product_category_name_english = 'telephony' OR
    product_category_name_english = 'electronics' OR
    product_category_name_english = 'consoles_games' OR
    product_category_name_english = 'computers' OR
    product_category_name_english = 'audio' OR
    product_category_name_english = 'cine_photo' OR
    product_category_name_english = 'tablets_printing_image') AND
    order_purchase_timestamp BETWEEN '2017-01-01' AND '2017-12-31';


SELECT
	ROUND(SUM(payment_value),2) AS sum_total_payment_tech_2018
FROM order_payments op
INNER JOIN
	orders o ON op.order_id = o.order_id
INNER JOIN
	order_items oi ON oi.order_id = op.order_id
INNER JOIN
	products p ON oi.product_id = p.product_id
INNER JOIN
	product_category_name_translation z ON p.product_category_name = z.product_category_name
WHERE
	(product_category_name_english = 'computer_accessories' OR
    product_category_name_english = 'telephony' OR
    product_category_name_english = 'electronics' OR
    product_category_name_english = 'consoles_games' OR
    product_category_name_english = 'computers' OR
    product_category_name_english = 'audio' OR
    product_category_name_english = 'cine_photo' OR
    product_category_name_english = 'tablets_printing_image') AND
    order_purchase_timestamp BETWEEN '2018-01-01' AND '2018-12-31';

-- ---------------------------------- 
-- ---------------------------------- 






-- Can you work out the average monthly income of all sellers? 
-- YES, IT's DONE ---> Check table per month and year!!!

SELECT
	ROUND(AVG(payment_value),2) AS avg_per_month,
    MONTH(order_purchase_timestamp) AS month,
    YEAR(order_purchase_timestamp) AS year
FROM order_payments op
INNER JOIN
	orders o ON o.order_id = op.order_id
WHERE
	order_purchase_timestamp BETWEEN '2017-04-01' AND '2018-03-31'
GROUP BY
	MONTH(order_purchase_timestamp),
    YEAR(order_purchase_timestamp)
ORDER BY
	month DESC;

-- ---------------------------------- 
-- ---------------------------------- 


    


-- Can you work out the average monthly income of Tech sellers?
-- YES, IT's DONE ---> Check table per month and year!!!

SELECT
	ROUND(AVG(payment_value),2) AS avg_per_month,
    MONTH(order_purchase_timestamp) AS month,
    YEAR(order_purchase_timestamp) AS year
FROM order_payments op
INNER JOIN
	orders o ON o.order_id = op.order_id
INNER JOIN
	order_items oi ON oi.order_id = op.order_id
INNER JOIN
	products p ON oi.product_id = p.product_id
INNER JOIN
	product_category_name_translation z ON p.product_category_name = z.product_category_name
WHERE
	(product_category_name_english = 'computer_accessories' OR
    product_category_name_english = 'telephony' OR
    product_category_name_english = 'electronics' OR
    product_category_name_english = 'consoles_games' OR
    product_category_name_english = 'computers' OR
    product_category_name_english = 'audio' OR
    product_category_name_english = 'cine_photo' OR
    product_category_name_english = 'tablets_printing_image') AND
    order_purchase_timestamp BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY
	MONTH(order_purchase_timestamp),
    YEAR(order_purchase_timestamp)
ORDER BY
	month DESC;

-- ---------------------------------- 
-- ---------------------------------- 






-- Can you work out the average monthly income of all sellers? 
SELECT
	total_month_income,
    num_payment_by_month,
    ROUND(total_month_income/num_payment_by_month, 2) AS average_income_per_month,
	month,
    year
FROM
	(
	SELECT
		SUM(op.payment_value) AS total_month_income,
		COUNT(DISTINCT o.order_id) AS num_payment_by_month,
		MONTH(o.order_purchase_timestamp) AS month,
		YEAR(o.order_purchase_timestamp) AS year
	FROM orders o
	INNER JOIN
		order_payments op ON o.order_id = op.order_id
	INNER JOIN
	order_items oi ON oi.order_id = op.order_id
INNER JOIN
	products p ON oi.product_id = p.product_id
INNER JOIN
	product_category_name_translation z ON p.product_category_name = z.product_category_name
WHERE
	(product_category_name_english = 'computer_accessories'
    OR product_category_name_english = 'telephony'
    OR product_category_name_english = 'electronics'
    OR product_category_name_english = 'consoles_games'
    OR product_category_name_english = 'computers'
    OR product_category_name_english = 'audio'
    OR product_category_name_english = 'cine_photo'
    OR product_category_name_english = 'tablets_printing_image')
    AND order_purchase_timestamp BETWEEN '2017-01-01' AND '2018-12-31'
	GROUP BY
		MONTH(o.order_purchase_timestamp),
		YEAR(o.order_purchase_timestamp)
	) AS total_income_by_month
ORDER BY
	year DESC,
    month DESC;


-- ---------------------------------- 
-- ---------------------------------- 


-- Can you work out the average monthly income of Tech sellers?
SELECT
	ROUND(total_month_income,4) AS total_mont_income,
    num_payment_by_month,
    ROUND(total_month_income/num_payment_by_month, 2) AS average_income_per_month,
    MID(order_purchase_timestamp, 1, 10),
	month,
    year
FROM
	(
	SELECT
		SUM(op.payment_value) AS total_month_income,
		COUNT(DISTINCT o.order_id) AS num_payment_by_month,
		MONTH(o.order_purchase_timestamp) AS month,
		YEAR(o.order_purchase_timestamp) AS year,
        order_purchase_timestamp
	FROM orders o
	INNER JOIN
		order_payments op ON o.order_id = op.order_id
	WHERE
		order_purchase_timestamp BETWEEN '2016-01-01' AND '2018-12-31'
	GROUP BY
		MONTH(o.order_purchase_timestamp),
		YEAR(o.order_purchase_timestamp),
        order_purchase_timestamp
	) AS total_income_by_month
ORDER BY
	year DESC,
    month DESC;

-- ---------------------------------- 
-- ---------------------------------- 


SELECT
	total_month_income,
    num_payment_by_month,
    ROUND(total_month_income/num_payment_by_month, 2) AS average_income_per_month,
    MID(order_purchase_timestamp, 1, 10) AS date
FROM
	(
	SELECT
		SUM(op.payment_value) AS total_month_income,
		COUNT(DISTINCT o.order_id) AS num_payment_by_month,
        order_purchase_timestamp
	FROM orders o
	INNER JOIN
		order_payments op ON o.order_id = op.order_id
	GROUP BY
        order_purchase_timestamp
	) AS total_income_by_month
ORDER BY
	order_purchase_timestamp;

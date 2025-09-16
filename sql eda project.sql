select *
from retail_sales;

-- Removing Null values ?
	select * 
    from retail_sales 
    where transactions_id is null
    or 
    sales_dates is null 
    or 
    sales_times is null
    or
    customer_id is null
    or
    gender is null 
    or
    age is null
    or 
    category is null 
    or 
    quantity is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null ;
    
    -- Data exploration 
-- How many sales we have ?
	select count(*) as total_sales_count 
    from retail_sales;
    
-- How many unique customers we have ?
	select count(distinct customer_id) as total_unique_customer
    from retail_sales;
    
-- How many categories we have 
	select distinct category 
    from retail_sales;
    
-- Data Analysis and Business Analysio
-- My Anlaysis and Findings 


-- Q1. Write a sql retrieve all columns for sales made on '2022-11-05'?
	select *
    from retail_sales
    where sales_dates = '2022-11-05';
    
-- Q2. write a sql query to retrieve all transactions where the category is clothing and the quantity is sold more than 3 in the month of nov-2022
		SELECT *
	FROM retail_sales
	WHERE category = 'clothing'
	AND quantity > 3
	AND EXTRACT(YEAR FROM sales_dates) = 2022
	AND EXTRACT(MONTH FROM sales_dates) = 11;

-- Q3. Write a sql query to calculate the total sales for each category 
	select category , sum(total_sale) as net_total_sale , count(*) as total_orders
    from retail_sales
    group by 1 ;

-- Q4. Write a sql query to find the average age of customers who purchased items from the 'beauty' category
		SELECT ROUND(AVG(age), 2) AS avg_age_beauty_customers
		FROM retail_sales
		WHERE category = 'Beauty';

-- Q5. Write a sql query to find all transactions where the total_sale is greater than 1000 
		SELECT *
		FROM retail_sales
		WHERE total_sale > 1000;

-- Q6. Write a sql query to find the total number of transactions(transaction_id) made by each gender in each category 
			SELECT 
				gender,
					category,
						COUNT(transactions_id) AS total_transactions
							FROM retail_sales
								GROUP BY gender, category
									ORDER BY gender, category;
-- Q7. Write a sql query to calculate the average sale for each month . find out best selling month in each year 
		SELECT year, month, avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sales_dates) AS year,
        EXTRACT(MONTH FROM sales_dates) AS month,
        ROUND(AVG(total_sale), 2) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sales_dates)
            ORDER BY AVG(total_sale) DESC
        ) AS rnk
    FROM retail_sales
    GROUP BY EXTRACT(YEAR FROM sales_dates), EXTRACT(MONTH FROM sales_dates)
) t
WHERE rnk = 1
ORDER BY year;

-- Q8. Write a sql query to find the top 5 customers based on the highest total sales?
		SELECT 
			customer_id,
				SUM(total_sale) AS total_sales
					FROM retail_sales
						GROUP BY customer_id
							ORDER BY total_sales DESC
						LIMIT 5;
-- Q9. Write a sql query to find the number of unique customers who purchased items from each category?
		SELECT 
			category,
				COUNT(DISTINCT customer_id) AS unique_customers
					FROM retail_sales
						GROUP BY category
							ORDER BY unique_customers DESC;

-- Q10. Write a sql query to create each shift and number of orders (Example morning <=12 , Afternoon Between 12 & 17 , Evening > 17)
		SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM sales_dates) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sales_dates) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(transactions_id) AS total_orders
FROM retail_sales
GROUP BY 
    CASE 
        WHEN EXTRACT(HOUR FROM sales_dates) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sales_dates) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END
ORDER BY shift;

		



# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_database`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_project_database;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sales_dates DATE,	
    sales_times TIME,
    customer_id INT,	
    gender VARCHAR(45),
    age INT,
    category VARCHAR(45),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

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

DELETE FROM retail_sales
WHERE 
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select *
    from retail_sales
    where sales_dates = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**:
```sql
SELECT *
	FROM retail_sales
	WHERE category = 'clothing'
	AND quantity > 3
	AND EXTRACT(YEAR FROM sales_dates) = 2022
	AND EXTRACT(MONTH FROM sales_dates) = 11;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT ROUND(AVG(age), 2) AS avg_age_beauty_customers
		FROM retail_sales
		WHERE category = 'Beauty';
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
				gender,
					category,
						COUNT(transactions_id) AS total_transactions
							FROM retail_sales
								GROUP BY gender, category
									ORDER BY gender, category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT 
			customer_id,
				SUM(total_sale) AS total_sales
					FROM retail_sales
						GROUP BY customer_id
							ORDER BY total_sales DESC
						LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
	SELECT 
			category,
				COUNT(DISTINCT customer_id) AS unique_customers
					FROM retail_sales
						GROUP BY category
							ORDER BY unique_customers DESC;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

This project demonstrates the use of **SQL** to analyze retail sales data. The objective was to extract insights and generate reports to support business decision-making.

## Key Highlights:

- Filtered and analyzed transactions based on **product categories, customer demographics, and sales periods**.
- Calculated **total sales, average sales per month, and top-selling customers**.
- Grouped data to find **number of transactions by gender and category**.
- Created **shift-wise sales analysis** (Morning, Afternoon, Evening).
- Applied **window functions** (RANK) to identify best-selling months in each year.
- Hands-on experience with **aggregate functions, GROUP BY, CASE statements, and subqueries**.

## Tools & Technologies:
- **SQL** (MySQL / PostgreSQL / SQL Server)
- Data analysis techniques: filtering, aggregation, ranking, and conditional logic.

This project showcases practical SQL skills to derive actionable business insights from retail sales data.
## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

linkedin profile : www.linkedin.com/in/praveen-kumar-nuthakki-64180a221



Thank you for your support, and I look forward to connecting with you!


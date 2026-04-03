CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

select * from retail_sales

-- checking for Null Values
SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

--Delete Null rows

DELETE FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

--TOTAL SALES
SELECT COUNT (*) AS TOTAL_SALES FROM RETAIL_SALES

--TOTAL NUMBER OF CUSTOMERS
SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_SALES FROM RETAIL_SALES

--NUMBER OF CATEGORIES
SELECT DISTINCT CATEGORY FROM RETAIL_SALES

-- Retrieve all columns for sales made on '2022-11-05
SELECT * FROM RETAIL_SALES
WHERE SALE_DATE = '2022-11-05'

-- Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022
SELECT * FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 2

--calculate the total sales (total_sale) for each category.
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1


--average age of customers who purchased items from the 'Beauty' category.

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

--find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000


--find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1

-- calculate the average sale for each month. Find out best selling month in each year
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

-- find the top 5 customers based on the highest total sales 
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

--create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift







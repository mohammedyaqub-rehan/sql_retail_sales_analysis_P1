-- SQL Retail Sales Analysis Project __

-- Create Table
Drop table if exists retail_sales;
Create Table retail_sales 
             (
                transactions_id INT PRIMARY KEY,
	            sale_date DATE,
	            sale_time TIME,
	            customer_id INT,
	            gender VARCHAR(20),
	            age INT,
	            category VARCHAR(20),
	            quantity INT,
				price_per_unit FLOAT,
	            cogs FLOAT,
	            total_sale FLOAT
			);	

select
	count(*)
from retail_sales	
			
-- Data cleaning

select*from retail_sales
where transactions_id is null

--
select*from retail_sales
where sale_date is null

--
select*from retail_sales
where sale_time is null

--
select*from retail_sales
where customer_id is null

--
select*from retail_sales
where gender is null

--
select*from retail_sales
where age is null

--
select*from retail_sales
where category is null

--
select*from retail_sales
where quantiy is null

--
select*from retail_sales
where
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 customer_id is null
	 or
	 gender is null
	 or
	 age is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
     price_per_unit is null
	 or
	 cogs is null
	 or
	 total_sale is null;

--
Delete from retail_sales
where
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 customer_id is null
	 or
	 gender is null
	 or
	 age is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
     price_per_unit is null
	 or
	 cogs is null
	 or
	 total_sale is null;

-- Data exploration

--How many sales we have ?
select count(*)as total_sales From retail_sales

-- How many unique customers we have ?
select count(Distinct customer_id)as total_sale from retail_sales

select count(Distinct category)as total_sale from retail_sales
select distinct category from retail_sales

--Data Analysis & Business key problems and answers



-- Q.1 Write a query to retrieve all columns for sales made on '2022-11-05'

Select*
from retail_sales
where sale_date = '2022-11-05';

--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing and the quantity sold is more than 4 in the month of Nov-22

select
	*
from retail_sales
where category ='Clothing'
And to_char(sale_date,'yyyy-mm')= 
'2022-11'
And quantiy >=4;
	
	
--Q.3 Write a SQL query to calculate the total sales (total sate) for Each catagory.

select
	category,
	sum(total_sale)as net_sale,
	count(*)as total_orders
	from retail_sales
	Group by 1

-- Q.4 write a SQL query to find the average age of customers who purchased itens from the "Beauty' category.

select
	Round(avg(age),2)as avg_age
from retail_sales
where category = 'Beauty';


--Q.5 Write a sql query to find all transactions where the total sale is greater than 1000.

select *from retail_sales
Where total_sale >1000


--Q.6 Write a s0L query to find the total number of transactions (transaction id) made by each gender in each category.

select
	category,
	gender,
	Count(*)as total_transactions
from retail_sales
Group
	by
	category,
	gender
	order by 1

--Q.7 write a SQL query to calculate the average sale for each month. Find out best selling month in each year


select
	EXTRACT(YEAR from sale_date)As year,
	EXTRACT(MONTH from sale_date)As 
	month,
	   AVG(total_sale) As avg_sale,
	   RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG (total_sale) DESC)AS rank
from retail_sales
Group by 1,2
Order by 1,2;

--Q.8  write a SQL query to find the top 5 customers based on the highest total sales
select
	customer_id,
	sum(total_sale) as total_sales
from retail_sales
Group by 1
Order  by 2 Desc
Limit 5

--Q.9 Write a sql query to find the number of unique customers who purchased items from each category ?

Select
	category,
	Count(Distinct customer_id) as unique_customers
from retail_sales
Group by category

--Q.10 Write a sql query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17 ,Evening >17)

With hourly_sale
As
(
Select*,
	Case
		when Extract(hour from sale_time)<12 then 'Morning'
		when extract(hour from sale_time)between 12 and 17 then 'Afternoon'
		else 'Evening'
	End as shift
from retail_sales
)
select
	shift,
	count(*)as total_stars
from hourly_sale
Group by shift

-- END OF PROJECT --
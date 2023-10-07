/* Pizza sales */

Select * 
from pizza_sales

--Total Revenue
Select SUM(total_price) AS Total_Revenue 
from pizza_sales


--Average Order Value
Select (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value 
from pizza_sales


--Total Pizzas Sold
Select SUM(quantity) AS Total_pizza_sold 
from pizza_sales


--Total Orders
Select COUNT(DISTINCT order_id) AS Total_Orders 
from pizza_sales


--Average Pizzas Per Order
Select CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) /
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
as Avg_Pizzas_per_order
from pizza_sales


--Daily Trend for Total Orders
Select DATENAME(DW, order_date) AS order_day,COUNT(DISTINCT order_id) AS total_orders
From pizza_sales
group by DATENAME(DW, order_date)


--Hourly Trend for Orders
Select DATEPART(HOUR, order_time) as order_hours, COUNT(DISTINCT order_id) as total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)


-- % of Sales by Pizza Category
Select pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue, CAST(SUM(total_price) * 100
/ (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
from pizza_sales
group by pizza_category

--% of Sales by Pizza Size
Select pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
from pizza_sales
group by pizza_size
order by pizza_size


--Total Pizzas Sold by Pizza Category
Select pizza_category, SUM(quantity) as Total_Quantity_Sold
from pizza_sales
where MONTH(order_date) = 2
group by pizza_category
order by Total_Quantity_Sold DESC


--Top 5 Best Sellers by Total Pizzas Sold
Select Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
from pizza_sales
group by pizza_name
order by Total_Pizza_Sold DESC


--Bottom 5 Best Sellers by Total Pizzas Sold
Select TOP 5 pizza_name, sum(quantity) as Total_pizzas_sold
From pizza_sales
group by pizza_name
order by sum(quantity) asc
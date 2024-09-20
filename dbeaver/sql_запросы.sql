select round(sum(sales)) as total_sales,
	round(sum(profit)) as total_profit,
	round((sum(profit) / sum(sales)) * 100, 2) as profit_ratio,
	round(AVG(discount) * 100, 2) as avg_discount
from orders o 

select order_id, round(sum(profit)) as profit_per_order
from orders o 
group by order_id
order by 1

select p.person, round(sum(o.sales)) as sales_per_manager
from orders o inner join people p on o.region = p.region 
group by 1
order by 2 desc

select Customer_ID , Customer_Name , sum(sales) sales_per_customer
from orders o 
group by Customer_ID , Customer_Name
order by Customer_Name 

select extract(month from order_date) as month, segment, round(sum(sales)) as Monthly_Sales_by_Segment
from orders o 
group by 1, 2
order by 1

select extract(month from order_date) as month, category, round(sum(sales)) as Monthly_Sales_by_Product_category
from orders o 
group by 1, 2
order by 1

Sales by Product Category over time
Sales and Profit by Customer
Customer Ranking
Sales per region

select extract(year from order_date) as year, category, round(sum(sales)) as Year_Sales_by_Product_category
from orders o 
group by 1, 2
order by 1



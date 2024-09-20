create schema dw;

--SHIPPING
create table dw.shipping_dim(
ship_id serial not null primary key,
ship_mode varchar(14) not null);

truncate table dw.shipping_dim;

insert into dw.shipping_dim
select 100 + row_number() over(), ship_mode
from (select distinct ship_mode from orders) o;

select * from dw.shipping_dim; 



--CUSTOMER
create table dw.customer_dim(
cust_id serial not null primary key,
customer_id varchar(8) not null,
customer_name varchar(22) not null);

truncate table dw.customer_dim;

insert into dw.customer_dim
select 100 + row_number() over(), customer_id, customer_name
from (select distinct customer_id, customer_name
	from orders) o;
	
select * from dw.customer_dim;



--GEOGRAPHY
create table dw.geo_dim(
geo_id serial not null primary key,
country varchar(13) not null,
city varchar(17) not null,
state varchar(20) not null,
postal_code varchar(20) null);

truncate table dw.geo_dim;

insert into dw.geo_dim
select 100 + row_number() over(), country, city, state, postal_code
from (select distinct country, city, state, postal_code from orders) o;

select * from dw.geo_dim;



--PRODUCT
create table dw.product_dim(
prod_id serial not null primary key,
product_id varchar(15) not null,
product_name varchar(127) not null,
category varchar(15) not null,
subcategory varchar(11) not null,
segment varchar(11) not null);

truncate table dw.product_dim;

insert into dw.product_dim
select 100 + row_number() over() as prod_id,
	product_id, product_name, category, subcategory, segment
from (select distinct product_id, product_name, category, subcategory, segment
	from orders) o;

select * from dw.product_dim;



--CALENDAR
-- examplehttps://tapoueh.org/blog/2017/06/postgresql-and-the-calendar/
CREATE TABLE dw.calendar_dim(
dateid serial  NOT null PRIMARY KEY,
year        int NOT NULL,
quarter     int NOT NULL,
month       int NOT NULL,
week        int NOT NULL,
date        date NOT NULL,
week_day    varchar(20) NOT NULL,
leap  varchar(20) NOT NULL);

truncate table dw.calendar_dim;
--
insert into dw.calendar_dim 
select 
to_char(date,'yyyymmdd')::int as date_id,  
       extract('year' from date)::int as year,
       extract('quarter' from date)::int as quarter,
       extract('month' from date)::int as month,
       extract('week' from date)::int as week,
       date::date,
       to_char(date, 'dy') as week_day,
       extract('day' from
               (date + interval '2 month - 1 day')
              ) = 29
       as leap
  from generate_series(date '2000-01-01',
                       date '2030-01-01',
                       interval '1 day')
       as t(date);

select * from dw.calendar_dim; 



--METRICS
create table dw.sales_fact(
sales_id serial not null primary key,
cust_id integer not null,
order_date_id integer not null,
ship_date_id integer not null,
prod_id integer not null,
ship_id integer not null,
geo_id integer not null,
order_id varchar(14) not null,
sales numeric(9,4) not null,
profit numeric(21,16) not null,
quantity integer not null,
discount numeric(4,2) not null);

truncate table dw.sales_fact

insert into dw.sales_fact
select 100 + row_number() over() as sales_id,
	cust_id, 
	to_char(order_date, 'yyyymmdd')::int as order_date_id,
	to_char(ship_date, 'yyyymmdd')::int as ship_date_id,
	p.prod_id,
	s.ship_id,
	geo_id,
	o.order_id,
	sales,
	profit,
	quantity,
	discount
from orders o
	inner join dw.customer_dim cd on o.customer_id = cd.customer_id and o.customer_name = cd.customer_name
	
	inner join dw.geo_dim g on o.country = g.country and o.city = g.city and o.state = g.state and o.postal_code = g.postal_code::int
	
	inner join dw.product_dim p on o.product_id = p.product_id and o.product_name = p.product_name 
		and o.category = p.category and o.subcategory = p.subcategory and o.segment = p.segment
		
	inner join dw.shipping_dim s on o.ship_mode = s.ship_mode;

select count(*) from dw.sales_fact sf; --9994!




		






























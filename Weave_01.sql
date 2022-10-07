-- STEP 1 
--Almost data_type of columns in dataraw are varchart(50), Hence, we have to convert they to appropriate data type

ALTER TABLE data_raw
	ALTER COLUMN week date;
ALTER TABLE data_raw
	ALTER COLUMN weekly_sales float;
ALTER TABLE data_raw
	ALTER COLUMN price float;

-- STEP 2: Over view

select count(*) as Total_Records from data_raw 
select sum(weekly_sales*price) as Total_Value from data_raw

 -- information of each column:
select table_name, column_name, data_type
	from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME = 'data_raw'

--STEP 3: Data Cleaning

--STEP 4: Data Query 

-- (4.1) What SKU have the best sale, how much?

select top 1 sku, sum(weekly_sales) as Max_Sales_by_SKU from data_raw
	group by sku
	order by sum(weekly_sales) desc

-- (4.2) What functionality have the best sale, how much?

select top 1  functionality, sum(weekly_sales) as Max_Sales_by_funtionality from data_raw
	group by functionality
	order by Max_Sales_by_funtionality desc;

-- (4.3) What Vendor have the best sale, how much?

select top 1  vendor, sum(weekly_sales) as Max_Sales_by_vendor from data_raw
	group by vendor
	order by Max_Sales_by_vendor desc;

-- (4.4) weeky_sales by week & SKU

Select week, sku, sum(weekly_sales) from dataraw
	group by week, sku
	order by week, sku

-- (4.5) feat_main_page_rate 

select count(*) as total_order from data_raw
select count(temp.week) as feat_main from
	(select * from data_raw where feat_main_page = 'TRUE') temp

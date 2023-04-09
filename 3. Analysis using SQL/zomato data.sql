SHOW DATABASES;

USE zomato_data_analysis;

/* Creating Table for importing data */

CREATE TABLE zomato_data (
	url MEDIUMTEXT,
    address MEDIUMTEXT,
    name TEXT,
    online_order TEXT,
	book_table TEXT,
    rate VARCHAR(64),
    votes INTEGER,
    phone VARCHAR(256),
    location TEXT,
    rest_type TEXT,
    dish_liked MEDIUMTEXT,
    cuisines MEDIUMTEXT,
    approx_cost_for_two_people INTEGER,
    menu_item LONGTEXT,
    listed_in_type TEXT,
    listed_in_city TEXT);
    
 
/* Data file after importing data */
 SELECT * FROM	zomato_data;
 
 SELECT COUNT(*) FROM zomato_data;

 
/* Check datatype of all columns */
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'zomato_data_analysis' AND 
TABLE_NAME   = 'zomato_data' AND COLUMN_NAME  in 
(Select COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'zomato_data_analysis' AND 
TABLE_NAME   = 'zomato_data');
 
 
/* Average rating of Top 20 restaurants */
SELECT name, ROUND(AVG(rate),1) AS Average_Rating 
FROM zomato_data 
GROUP BY name ORDER BY Average_Rating DESC, name ASC limit 20;

-- 4 Restaurants have highest average rating


/* Top 20 Restaurant chains */
SELECT name, COUNT(name) AS Number_of_Outlets 
FROM zomato_data GROUP BY name ORDER BY Number_of_Outlets DESC
LIMIT 20;

-- Cafe Coffee Day has most Restaurants emerging as Biggest Restaurant chain


/* % of Restaurants that do not accept online orders */
SELECT DISTINCT (online_order), COUNT(*) AS Total_orders, 
ROUND(COUNT(online_order) * 100/(SELECT COUNT(*) FROM zomato_data),2) AS Percent_of_total_orders
 FROM zomato_data GROUP BY online_order;
 
 -- More than 50% restaurants do not accept online orders
 
 
 /* % of Restaurants that provide table booking */
 Select DISTINCT book_table, COUNT(*) AS Total_bookings, 
 ROUND((COUNT(book_table) * 100/(SELECT COUNT(*) FROM zomato_data)),2) AS Percent_of_Total
 FROM zomato_data GROUP BY book_table;
 
 -- Nearly 87.5% of restaurants do not have table_booking option
 
 
/*What are the Top 20 Restaurants types */
SELECT DISTINCT rest_type, COUNT(rest_type) AS Number_of_Restaurants FROM zomato_data
GROUP BY rest_type ORDER BY Number_of_Restaurants DESC LIMIT 20;

-- Quick Bites and Casual Dining are the top restaurant type


/* Top 10 Highest voted Restaurants */
SELECT DISTINCT name, MAX(votes) AS Number_of_votes FROM zomato_data
 GROUP BY name ORDER BY Number_of_votes DESC LIMIT 10;

-- 'Byg Brewski Brewing Company', Toit and Tryffles are some highest voted restaurants


/* Number of Restaurants at different locations */
SELECT DISTINCT location, COUNT(DISTINCT name) AS Number_of_Restaurants FROM zomato_data
 GROUP BY location ORDER BY Number_of_Restaurants DESC LIMIT 10;
 
 -- Whitefield has most number of restaurants
 
 
 /* Top 10 Cuisines served in Restaurants */
 Select DISTINCT cuisines, COUNT(cuisines) AS Number_of_Restaurants 
 FROM zomato_data GROUP BY cuisines ORDER BY Number_of_Restaurants DESC;
 
 -- North Indian is served in most of the Restaurants
 
 
 /* Cost vs Rating vs Online order */
 Select online_order, SUBSTRING(rate,1,3) AS Rating, approx_cost_for_two_people 
  FROM zomato_data ORDER BY Rating DESC, approx_cost_for_two_people;
  
-- Good restaurants costs nearly 400 bucks for two people which also accepts online order


/* Difference b/w votes of restaurants accepting and not accepting online orders */
SELECT DISTINCT online_order, SUM(votes) FROM  zomato_data GROUP BY online_order;

-- The restaurants that accepts online orders gets more votes


/* Difference b/w price of restaurants accepting and not accepting online orders*/
SELECT DISTINCT approx_cost_for_two_people, COUNT(*) AS Cost_count FROM zomato_data 
GROUP BY approx_cost_for_two_people ORDER BY Cost_count DESC;

-- Max Restaurants costs 300 to 500 for two people


/* Top 10 Most Expensive Restaurants */
SELECT name, MAX(approx_cost_for_two_people) AS Max_Cost FROM zomato_data 
GROUP BY name ORDER BY Max_cost DESC LIMIT 10;

-- Le Cirque Signature - The Leela Palace is the costliest Restaurant


/* Top 10 Cheapest Restaurants */
SELECT name, MIN(approx_cost_for_two_people) AS Min_Cost FROM zomato_data 
GROUP BY name ORDER BY Min_cost ASC LIMIT 10;

-- Srinidhi Sagar Deluxe, Srinidhi Sagar, Srinidhi Sagar Food Line are the Cheapest Restaurants


/* Top 10 location having cheapest Restaurants */
SELECT DISTINCT location, MIN(approx_cost_for_two_people) AS Min_Cost FROM zomato_data 
GROUP BY location ORDER BY Min_cost ASC, location LIMIT 10;

-- Domlur, Indiranagar, Old Airport Road are the cheapest places to eat


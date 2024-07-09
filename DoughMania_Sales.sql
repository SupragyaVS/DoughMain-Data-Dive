/*KEY FINDINGS*/ 

/*Total Revenue: The sum of the total price of all pizza orders*/ 

SELECT SUM(TOTAL_PRICE)
AS TOTAL_REVENUE
FROM pizza_sales;


/*Average Order Value: The average amount spent per order, calculated by dividing the total revenue by the total number of orders*/ 

SELECT ROUND(SUM(TOTAL_PRICE)/COUNT(DISTINCT(ORDER_ID)),2)
AS AVERAGE_ORDER_VALUE
FROM pizza_sales;


/*Total Pizzas Sold: The sum of the quantities of all pizzas sold*/ 

SELECT COUNT(DISTINCT(PIZZA_ID))
AS TOTAL_PIZZAS_SOLD
FROM pizza_sales;


/*Total Orders: The total number of orders placed*/ 

SELECT COUNT(UNIQUE(ORDER_ID))
AS TOTAL_ORDERS
FROM pizza_sales;


/*Average Pizzas Per Order: The average number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders*/ 

SELECT ROUND(COUNT(UNIQUE(PIZZA_ID))/COUNT(UNIQUE(ORDER_ID)),2)
AS AVG_PIZZAS_PER_ORDER
FROM pizza_sales;


/*Chart Requirements*/

/*Daily Trend for Total Orders*/ 

SELECT TO_CHAR(ORDER_DATE, 'Day') AS Weekday, COUNT(UNIQUE(PIZZA_ID)) AS Orders
FROM pizza_sales 
GROUP BY TO_CHAR(ORDER_DATE, 'Day');


/*Hourly Trend for Total Orders*/ 

SELECT EXTRACT(Hour from ORDER_TIME) AS Hour, COUNT(UNIQUE(PIZZA_ID)) AS Orders
FROM pizza_sales 
GROUP BY EXTRACT(Hour from ORDER_TIME);


/*Percentage of Sales by Pizza Category*/ 

SELECT Pizza_Category AS Category, SUM(Total_Price) AS Total_Sale,
ROUND(COUNT(Pizza_category)*100/(SELECT COUNT(Pizza_Category) FROM pizza_sales),2) AS Total_Share_Of_Orders,
ROUND(SUM(Total_Price)*100/(SELECT SUM(Total_Price) FROM pizza_sales),2) AS Total_Share_Of_Revenue 
FROM pizza_sales
GROUP BY Pizza_category;


/*Percentage of Sales by Pizza Size*/ 

SELECT Pizza_Size AS Pizza_Size,
ROUND(COUNT(Pizza_size)*100/(SELECT COUNT(Pizza_size) FROM pizza_sales),2) AS Total_Share
FROM pizza_sales
GROUP BY Pizza_size;


/*Total Pizzas Sold by Pizza Category*/ 

SELECT Pizza_Category AS Category, SUM(Quantity) AS Total_Units
FROM pizza_sales
GROUP BY Pizza_category;

/*Top 5 Best Sellers by Total Pizzas Sold*/ 

SELECT Pizza_Name AS Name, Sum(Quantity) AS Total_Units
FROM pizza_sales
GROUP BY Pizza_Name
ORDER BY Sum(Quantity) DESC
FETCH NEXT 5 ROWS ONLY;

/*Bottom 5 Worst Sellers by Total Pizzas Sold*/

SELECT Pizza_Name AS Name, Sum(Quantity) AS Total_Units
FROM pizza_sales
GROUP BY Pizza_Name
ORDER BY Sum(Quantity) ASC
FETCH NEXT 5 ROWS ONLY;









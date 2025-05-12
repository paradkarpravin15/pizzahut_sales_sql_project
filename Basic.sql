-- Basic:
-- Retrieve the total number of orders placed.
SELECT count(order_id) AS total_orders from orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    SUM(od.quantity * p.price) AS total_revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
    pt.pizza_name, p.price
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    p.size, COUNT(od.order_details_id) order_count
FROM
    pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY order_count DESC;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pt.pizza_name, SUM(quantity) AS quantities
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.pizza_name
ORDER BY quantities DESC
LIMIT 5;





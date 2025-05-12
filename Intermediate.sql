-- Intermediate:
-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pt.category, SUM(od.quantity) AS total_quantity
FROM
    pizza_types pt
        JOIN
    pizzas p USING (pizza_type_id)
        JOIN
    order_details od USING (pizza_id)
GROUP BY pt.category
ORDER BY total_quantity DESC;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY hour;

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(pizza_name) AS distribution
FROM
    pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(total_quantity)) AS avg_orders_per_day
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) AS total_quantity
    FROM
        orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.order_date) AS order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pt.pizza_name, SUM(od.quantity * p.price) AS total_revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.pizza_name
ORDER BY total_revenue DESC
LIMIT 3;





-- Advanced:
-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pt.category,
    ROUND(SUM(od.quantity * p.price) / (SELECT 
                    ROUND(SUM(od.quantity * p.price), 2) AS total_sales
                FROM
                    order_details od
                        JOIN
                    pizzas p ON p.pizza_id = od.pizza_id) * 100,
            2) AS revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.category
ORDER BY revenue DESC;

-- Analyze the cumulative revenue generated over time.
SELECT order_date,
SUM(revenue) OVER(ORDER BY order_date) AS cum_revenue
FROM
(SELECT o.order_date, SUM(od.quantity*p.price) as revenue
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
JOIN pizzas p
ON od.pizza_id = p.pizza_id
GROUP BY o.order_date) AS Sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT pizza_name, revenue, revenue_rank
FROM 
(SELECT category, pizza_name, revenue,
RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS revenue_rank
FROM
(SELECT pt.category, pt.pizza_name, SUM(od.quantity*p.price) as revenue
FROM pizza_types pt
JOIN pizzas p USING (pizza_type_id)
JOIN order_details od USING (pizza_id)
GROUP BY pt.category, pt.pizza_name) AS b) AS b
WHERE revenue_rank <= 3;

WITH revenue_per_pizza AS (
    SELECT 
        pt.category,
        pt.pizza_name AS pizza_name,
        SUM(od.quantity * p.price) AS total_revenue,
        RANK() OVER (PARTITION BY pt.category ORDER BY SUM(od.quantity * p.price) DESC) AS revenue_rank
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.pizza_name
)
SELECT category, pizza_name, total_revenue
FROM revenue_per_pizza
WHERE revenue_rank <= 3;


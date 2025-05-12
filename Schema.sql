create database pizzahut;
use pizzahut;

CREATE TABLE order_details(
order_details_id INT NOT NULL,
order_id INT NOT NULL,
pizza_id VARCHAR(50) NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY (order_details_id)
);

CREATE TABLE orders(
order_id INT NOT NULL,
order_date date NOT NULL,
order_time TIME NOT NULL,
PRIMARY KEY (order_id)
);

CREATE TABLE pizza_types(
pizza_type_id VARCHAR(50) NOT NULL,
pizza_name VARCHAR(50) NOT NULL,
category VARCHAR(50) NOT NULL,
ingredients VARCHAR(100) NOT NULL,
PRIMARY KEY (pizza_type_id)
);

CREATE TABLE pizzas(
pizza_id VARCHAR(50) NOT NULL,
pizza_type_id VARCHAR(50) NOT NULL,
size VARCHAR(50) NOT NULL,
price INT NOT NULL,
PRIMARY KEY (pizza_id)
);
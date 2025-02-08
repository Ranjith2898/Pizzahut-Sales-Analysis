-- Basic:
use pizzahut;
-- 1.Retrieve the total number of orders placed.
select count(order_id) as total_orders
from orders;

-- 2.Calculate the total revenue generated from pizza sales.
select round(sum(od.quantity*p.price),2) as total_revenue
from order_details od 
join pizzas p on p.pizza_id=od.pizza_id;

-- 3.Identify the highest-priced pizza.
select pi.name,p.price
from pizza_types pi 
join pizzas p on p.pizza_type_id=pi.pizza_type_id
order by p.price desc 
limit 1;

-- 4.Identify the most common pizza size ordered.
select p.size,count(od.order_details_id) as Total_orders
from pizzas p 
join order_details od on 
p.pizza_id=od.pizza_id
group by p.size
order by Total_orders desc;

-- 5.List the top 5 most ordered pizza types along with their quantities.
select pi.name, sum(od.quantity) as quantity
from pizza_types pi
join pizzas p on p.pizza_type_id=pi.pizza_type_id
join order_details od on od.pizza_id=p.pizza_id
group by pi.name 
order by quantity desc 
limit 5;
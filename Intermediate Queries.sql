-- Intermediate:
-- 1.Join the necessary tables to find the total quantity of each pizza category ordered.
select pi.category, sum(od.quantity) as total_quantity
from order_details od 
join pizzas p on p.pizza_id=od.pizza_id
join pizza_types pi on pi.pizza_type_id=p.pizza_type_id
group by pi.category;

-- 2.Determine the distribution of orders by hour of the day.
select hour(order_time) as Hour,count(order_id) as orders
from orders
group by hour(order_time);

-- 3.Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name) as Pizaa_Distribution 
from pizza_types
group by category;

-- 4.Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(quantity),0) as avg_no_of_pizzas_ordered
from (select o.order_date,sum(od.quantity) as quantity
from orders o 
join order_details od on o.order_id = od.order_id
group by o.order_date) as quantity;


-- 5.Determine the top 3 most ordered pizza types based on revenue.
select pi.name,sum(od.quantity * p.price) as revenue 
from order_details od 
join pizzas p on p.pizza_id = od.pizza_id 
join pizza_types pi on pi.pizza_type_id = p.pizza_type_id
group by pi.name
order by revenue desc 
limit 3;

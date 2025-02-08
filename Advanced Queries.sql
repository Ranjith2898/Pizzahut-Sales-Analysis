-- Advanced:
-- 1.Calculate the percentage contribution of each pizza type to total revenue.
select pi.category, round(sum(od.quantity * p.price) /(select sum(od.quantity*p.price) from order_details od 
join pizzas p on od.pizza_id = p.pizza_id) * 100, 2) as Revenue_Percentage_contribution
from order_details od 
join pizzas p on p.pizza_id = od.pizza_id 
join pizza_types pi on pi.pizza_type_id = p.pizza_type_id
group by pi.category
order by Revenue_Percentage_contribution desc;

-- 2. Analyze the cumulative revenue generated over time.

select order_date,
round(sum(revenue) over (order by order_date),2) as cumm_revenue
from (select o.order_date,sum(od.quantity * p.price) as revenue
from orders o 
join order_details od on o.order_id = od.order_id
join pizzas p on p.pizza_id=od.pizza_id
group by o.order_date) as Sales;

-- 3.Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select category, name, round(revenue,2), ranck from 
(select category,name,revenue,
rank() over(partition by category order by revenue desc) as ranck
from (select pi.category, pi.name, sum(od.quantity*p.price) as revenue 
from order_details od 
join pizzas p on p.pizza_id = od.pizza_id 
join pizza_types pi on pi.pizza_type_id = p.pizza_type_id
group by pi.category, pi.name
) as A) as B 
where ranck <= 3;
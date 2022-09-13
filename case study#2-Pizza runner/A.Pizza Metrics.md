# 💡Case Study Questions- A.Pizza Metrics

**🍕1. How many pizzas were ordered?**
``` SQL
select count(pizza_id) as total_pizza_ordered  
from pizza_runner.customer_order_temp; 
```
![q1](https://user-images.githubusercontent.com/98269318/189185371-3a04d690-5bf1-4fa1-b677-b5b4a0bfda93.png)

**Ans**: Total number of pizzas ordered - 14

**🍕2. How many unique customer orders were made?**
``` SQL
 select count(distinct(order_id)) as unique_customer_id  
 from pizza_runner.customer_order_temp; 
 ```
 ![q1](https://user-images.githubusercontent.com/98269318/189186971-0678b355-e5bf-4178-80e9-84af2f4c91ed.png)

**Ans**: There were 10 unique customer orders made.

**🍕3. How many successful orders were delivered by each runner?**
``` SQL
  select runner_id,count(order_id) as successful_orders
  from pizza_runner.runner_orders_temp
  where duration !=0
  group by runner_id;
```
![q3](https://user-images.githubusercontent.com/98269318/189188015-09550ff9-173b-4b44-b004-89eae2cdded7.png)

**Ans**: Successful orders made by runners:
- **Runner Id: 1**, made 4 successful orders
- **Runner Id: 2**, made 3 successful orders
- **Runner Id: 3**, made 1 successful orders 

**🍕4.How many of each type of pizza was delivered?**
``` SQL
  select p.pizza_name, count(c.pizza_id) as types_of_pizza
  from pizza_runner.customer_order_temp as c
  join pizza_runner.pizza_names as p
  on c.pizza_id= p.pizza_id
  join pizza_runner.runner_orders as r
  on c.order_id=r.order_id
  where duration !=0
  group by p.pizza_name;
  ```
  ![q4](https://user-images.githubusercontent.com/98269318/189192510-ed29979b-b06d-4b34-b9a0-a02803d48586.png)

**Ans**: Type of pizzas delivered:
- There are **9** type of pizzas for non-veg lovers
- There are **3** type of pizzas for vegeterian

**🍕5.How many Vegetarian and Meatlovers were ordered by each customer?**
 ``` SQL
 select c.customer_id, p.pizza_name as type_of_pizza, count(p.pizza_id) as no_of_pizza
  from pizza_runner.customer_order_temp as c
  join pizza_runner.pizza_names as p
  on c.pizza_id=p.pizza_id
  group by c.customer_id, p.pizza_name
  order by c.customer_id;
```
![d4](https://user-images.githubusercontent.com/98269318/189496796-c67d7877-244d-48df-baff-3bf0aeb69568.png)

**Ans**: 
- Customer 101 ordered **2** meat lovers & **1** vegetarian pizza
- Customer 102 ordered **3** meat lovers & **1** vegetarian pizza
- Customer 103 ordered **3** meat lovers & **1** vegetarian pizza
- Customer 104 ordered **2** meat lovers & **0** vegetarian pizza
- Customer 105 ordered **0** meat lovers & **1** vegetarian pizza

**🍕6.What was the maximum number of pizzas delivered in a single order?**
``` SQL
 select c.order_id, count(c.pizza_id) as no_of_pizza
  from pizza_runner.customer_order_temp as c
  join pizza_runner.runner_orders_temp as r
  on c.order_id=r.order_id
  where r.distance !=0
  group by c.order_id;
  ```
  ![p6](https://user-images.githubusercontent.com/98269318/189516209-1811cfbc-3eb4-4512-8846-f0e803ca8630.png)
  
  **Ans**: Mximum number of pizzas deliverd in a single order:
  - Order_id 1 deliverd **1** pizza
  - Order_id 2 deliverd **1** pizza
  - Order_id 3 deliverd **2** pizza
  - Order_id 4 deliverd **3** pizza
  - Order_id 5 deliverd **1** pizza
  - Order_id 7 deliverd **1** pizza
  - Order_id 8 deliverd **1** pizza
  - Order_id 10 deliverd **2** pizza

**🍕7.For each customer, how many delivered pizzas had at least 1 change and how many had no changes?**
``` SQL
select c.customer_id,
 sum(
 case when c.exclusions<> ' ' or c.extras<> ' ' then 1
 else 0
end) as  at_least_one_change,
sum(case when c.exclusions=' ' or c.extras=' ' then 1
else 0
end) as no_change
from pizza_runner.customer_order_temp as c
join pizza_runner.runner_orders_temp as r
on c.order_id=r.order_id 
where distance !=0
group by customer_id
order by customer_id;
```
**Ans**: Delivered pizza that had at least 1 change and no change:
- Customer 101 

**🍕8.How many pizzas were delivered that had both exclusions and extras? **
``` SQL
select c.customer_id,
 sum(
 case when c.exclusions<> ' ' and c.extras<> ' ' then 1
 else 0
end) as  both_exclusions_extras
from pizza_runner.customer_order_temp as c
join pizza_runner.runner_orders_temp as r
on c.order_id=r.order_id 
where distance !=0
group by customer_id
order by customer_id;
```

**🍕9.What was the total volume of pizzas ordered for each hour of the day?**
``` SQL
select
hour(order_time)as hour_of_day,
count(c.order_id) as volume
from pizza_runner.customer_order_temp as c
group by hour_of_day;
```

**🍕10.What was the volume of orders for each day of the week?**
``` SQL
select 
weekday(c.order_time)as day_of_week,
count(c.order_id) as total_pizza_ordered
from pizza_runner.customer_order_temp as c
group by day_of_week;
```

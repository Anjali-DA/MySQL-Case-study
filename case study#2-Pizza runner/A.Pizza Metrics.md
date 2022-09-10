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


# 🔖Case Study Questions- A.Pizza Metrics

**🍕1. How many pizzas were ordered?**
```
select count(pizza_id) as total_pizza_ordered  
from pizza_runner.customer_order_temp; 
```
![q1](https://user-images.githubusercontent.com/98269318/189185371-3a04d690-5bf1-4fa1-b677-b5b4a0bfda93.png)

**Ans**: Total number of pizzas ordered - 14

**🍕2. How many unique customer orders were made?**
```
 select count(distinct(order_id)) as unique_customer_id  
 from pizza_runner.customer_order_temp; 
 ```
 ![q1](https://user-images.githubusercontent.com/98269318/189186971-0678b355-e5bf-4178-80e9-84af2f4c91ed.png)

**Ans**: There were 10 unique customer orders made.

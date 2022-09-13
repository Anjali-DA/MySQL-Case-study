# 💡Case Study Questions

**🍕1.How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)**
``` SQL
select extract(week from ru.registration_date) as registration_week,  count(runner_id) as runner_signed_up
from pizza_runner.runners as ru
group by registration_week;
```
![b1](https://user-images.githubusercontent.com/98269318/189396609-2007ca62-8e44-44dc-a83c-f7d91b2a7212.png)

*Note: The output is given as week0, week1, week2, so for better understanding let us take week1, week2 & week3*

**Ans**: Runners signed up for each 1 week period:
- In week 1 & week 3, one runner signed up
- In week 2, two runners signed up

**🍕2.What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?**
``` SQL
select r.runner_id as each_runner, round(avg(extract(minute from r.pickup_time)),2) as avg_pickup_time
from pizza_runner.runner_orders as r
group by runner_id;
```
![a2](https://user-images.githubusercontent.com/98269318/189721314-6d78df7c-49ef-4844-82b2-22f2afecbea9.png)

**Ans**: Average time took bt each runner to arrive at the Pizza Runner HQ to pickup the order:
- Runner 1 took **21.75** mins
- Runner 2 took **32.67** mins
- Runner 3 took **10.00** mins

**🍕3.Is there any relationship between the number of pizzas and how long the order takes to prepare?**
``` SQL
with rel_pizza_time as(
select count(c.order_id) as no_of_pizza, timediff(r.pickup_time,c.order_time) as prep_time,c.order_id,c.order_time,r.pickup_time
from pizza_runner.customer_order_temp as c
join pizza_runner.runner_orders_temp as r
on c.order_id=r.order_id
where r.distance!=0
group by c.order_id)

select no_of_pizza, prep_time
from rel_pizza_time
group by no_of_pizza;
``` 
![a3](https://user-images.githubusercontent.com/98269318/189722020-160377b3-db72-4a1e-9e13-33c2d364f3ec.png)

**Ans**: Yes, there is relationship between the number of pizzas and how long the order takes to prepare.
- It took **10:32 mins** for preparing 1 pizza
- It took **21:14 mins** for preparing 2 pizzas
- It took **29:17 mins** for preparing 3 pizzas

**🍕4.What was the average distance travelled for each customer?**
``` SQL
select c.customer_id as customers, round(avg(r.distance),2) as average_distance
from pizza_runner.customer_order_temp as c
join pizza_runner.runner_orders_temp as r
on c.order_id=r.order_id
where distance !=0
group by c.customer_id;
```
![a4](https://user-images.githubusercontent.com/98269318/189723816-ed38f2fc-b82c-40f2-88bb-9c4b3e738486.png)

**Ans**: Average distance travelled by the runners for each customer:
- For customer 101, avg distance travelled by the runners is **20Km** 
- For customer 102, avg distance travelled by the runners is **14.75Km**
- For customer 103, avg distance travelled by the runners is **23Km**
- For customer 104, avg distance travelled by the runners is **10Km**
- For cistomer 105, avg distance travelled by the runners is **25Km**

**🍕5.What was the difference between the longest and shortest delivery times for all orders?**
``` SQL
select max(r.duration)-min(r.duration) as difference_duration
from pizza_runner.runner_orders_temp as r
where duration !=0;
```
![a5](https://user-images.githubusercontent.com/98269318/189972232-09ad70b2-e5b2-43a8-a010-9173e57171ea.png)

**Ans**: The difference between the longest and shortest delivery times for all orders is **30 minutes**

**🍕6. What was the average speed for each runner for each delivery and do you notice any trend for these values?**
``` SQL
select r.runner_id, r.order_id, round(avg(distance/(duration/60)),2) as average_speed
from pizza_runner.runner_orders_temp as r
where distance !=0
group by r.order_id;
```
![a6](https://user-images.githubusercontent.com/98269318/189973248-a48df61d-c5e5-4e15-b87f-d61fd160cbdb.png)

**Ans**: The average speed for each runner for each delivery:
- Runeer 1's average speed for each delivery **37.50, 44.44, 39.00 & 60.00 (Km/hr)**
- Runeer 2's average speed for each delivery **34.00, 60.00, 92.00 (Km/hr)**
- Runeer 3's average speed for each delivery **40.00 (Km/hr)**

**🍕7. What is the successful delivery percentage for each runner?**
``` SQL
select r.runner_id, round(100*sum(case when distance is null then 0 else 1 end)/count(*),0) as success_percentage
from pizza_runner.runner_orders_temp as r
group by r.runner_id;
```
![a7](https://user-images.githubusercontent.com/98269318/189977847-db3f1b13-1403-43a7-aeb5-338668d8ff9c.png)

 **Ans**: The successful delivery percentage for each runner:
 - Runner 1 has **100%**.
 - Runner 2 has **75%**.
 - Runner 3 has **50%**.


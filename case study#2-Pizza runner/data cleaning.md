# 🍕Data cleaning

**🔖Cleaning Table-2: customer_orders**

- Removing null or NaN with blank space ' ' from exclusions & extras

``` SQL
create table pizza_runner.customer_order_temp as
select order_id,customer_id,pizza_id,
case
when exclusions is null or exclusions like 'null' then ' '
else exclusions
end as exclusions,
case 
when extras is null or extras like '%n%' then ' '
else extras
end as extras,
order_time
from pizza_runner.customer_orders;

select* from pizza_runner.customer_order_temp;
```
![table1](https://user-images.githubusercontent.com/98269318/188915649-2168c602-4fb7-490e-b00e-725b43cafd9d.png)


**🔖Cleaning Table-3: Runner_orders**

- Removing null or NaN with blank space ' ' from pickup_time, distance, duration and cancellation
- Removing **km** from distance by using TRIM function
- Removing **mins**, **minutes** & **minute** from duration by using TRIM function
``` SQL
create table pizza_runner.runner_orders_temp as
select order_id, runner_id,
case
when pickup_time like 'null' then null 
else pickup_time
end as pickup_time,
case 
when distance like '%km' then trim('km' from distance)
when distance like 'null' then null
else distance
end as distance,
case
when duration like '%mins' then trim('mins' from duration)
when duration like '%minutes' then trim('minutes' from duration)
when duration like '%minute' then trim('minute' from duration)
when duration like 'null' then null
else duration 
end as duration,
case 
when cancellation like 'null' or cancellation like 'NaN' then null
else cancellation
end as cancellation
from pizza_runner.runner_orders;


select* from pizza_runner.runner_orders_temp;
```
![Table2](https://user-images.githubusercontent.com/98269318/188916239-d9ed98f7-569d-4c24-9446-e01e36d3d583.png)

**🔖Alternating the data types of table-3: runner_orders**

- Converting string to datetime in column pickup_time
- Converting string to decimal in column distance
- Converting string to integer in column duration
``` SQL
alter table pizza_runner.runner_orders_temp
modify column pickup_time datetime,
modify column distance decimal(5,1),
modify column duration int;
```

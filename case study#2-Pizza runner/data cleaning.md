# Data cleaning

**Cleaning Table-1: customer_orders**

- Removing null or NaN with blank space ' ' from exclusions & extras

```
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

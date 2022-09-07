# Data cleaning

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

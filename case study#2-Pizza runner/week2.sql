create schema pizza_runner;
#Table-1
create table pizza_runner.runners(
runner_id int,
registration_date date);

insert into pizza_runner.runners(runner_id, registration_date)
values
(1,'2021-01-01'),
(2,'2021-01-03'),
(3,'2021-01-08'),
(4,'2021-01-15');

select* from pizza_runner.runners;
#Table-2
create table pizza_runner.customer_orders(
order_id int,
customer_id int,
pizza_id int,
exclusions varchar(5),
extras varchar(5),
order_time timestamp);

insert into pizza_runner.customer_orders(order_id, customer_id, pizza_id, exclusions,extras, order_time)
values
(1,101,1,' ',' ','2021-01-01 18:05:02'),
(2,101,1,' ',' ','2021-01-01 19:00:52'),
(3,102,1,' ',' ','2021-01-02 23:51:23'),
(3,102,2,' ','NAN','2021-01-02 23:51:23'),
(4,103,1,'4',' ','2021-01-04 13:23:46'),
(4,103,1,'4',' ','2021-01-04 13:23:46'),
(4,103,2,'4',' ','2021-01-04 13:23:46'),
(5,104,1,'null','1','2021-01-08 21:00:29'),
(6,101,2,'null','null','2021-01-08 21:03:13'),
(7,105,2,'null','1','2021-01-08 21:20:29'),
(8,102,1,'null','null','2021-01-09 23:54:33'),
(9,103,1,'4','1, 5','2021-01-10 11:22:59'),
(10,102,1,'null','null','2021-01-11 18:34:49'),
(10,104,1,'2,6','1,4','2021-01-11 18:34:49');

select* from pizza_runner.customer_orders;

#Table-3
create table pizza_runner.runner_orders(
order_id int,
runner_id int,
pickup_time varchar(20),
distance varchar(10),
duration varchar(10),
cancellation varchar(30));

insert into pizza_runner.runner_orders(order_id,runner_id, pickup_time, distance, duration, cancellation)
values
(1,1,'2021-01-01 18:15:34','20km','32 minutes',' '),
(2,1,'2021-01-01 19:10:54','20km','27 minutes',' '),
(3,1,'2021-01-03 00:12:37','13.4km','20 mins','NaN'),
(4,2,'2021-01-04 13:53:03','23.4','40','NaN'),
(5,3,'2021-01-08 21:10:57','10','15','NaN'),
(6,3,'null','null','null','Restaurant Cancellation'),
(7,2,'2020-01-08 21:30:45','25km','25mins','null'),
(8,2,'2020-01-10 00:15:02','23.4 km','15 minute','null'),
(9,2,'null','null','null','Customer Cancellation'),
(10,1,'2020-01-11 18:50:20','10km','10minutes','null');

select* from pizza_runner.runner_orders;

#Table-4
create table pizza_runner.pizza_names(
pizza_id int,
pizza_name varchar(15));

insert into pizza_runner.pizza_names(pizza_id, pizza_name)
values
(1,'Meat Lovers'),
(2,'Vegetarian');

select* from pizza_runner.pizza_names;

#Table-5
create table pizza_runner.pizza_id(
pizza_id int,
toppings varchar(30));

insert into pizza_runner.pizza_id(pizza_id,toppings)
values
(1,'1, 2, 3, 4, 5, 6, 8, 10'),
(2,'4, 6, 7, 9, 11, 12');
select* from pizza_runner.pizza_id;

#Table-6
create table pizza_runner.topping_name(
topping_id int,
topping_name varchar(30));

insert into pizza_runner.topping_name(topping_id,topping_name)
value
(1,'Bacon'),
(2,'BBQ Sauce'),
(3,'Beef'),
(4,'Cheese'),
(5,'Chicken'),
(6,'Mushrooms'),
(7,'Onions'),
(8,'Pepperoni'),
(9,'Peppers'),
(10,'Salami'),
(11,'Tomatoes'),
(12,'Tomato Sauce');

select* from pizza_runner.topping_name;

#Data cleaning --- cleaning table-2
#creating a temporary table
create table pizza_runner.customer_order_temp as
select order_id,customer_id,pizza_id,
case
when exclusions is null or exclusions like 'null' then ' '
else exclusions
end as exclusions,
case 
when extras is null or extras like '%n%' then ' '
else extras
end as extras
from pizza_runner.customer_orders;

select* from pizza_runner.customer_order_temp;

#Data cleaning ---- cleaning table-3
create table pizza_runner.runner_orders_temp as
select order_id, runner_id,
case 
when pickup_time like 'null' then ' '
else pickup_time
end as pickup_time,
case 
when distance like 'null' then ' '
when distance like '%km' then trim('km' from distance)
else distance
end as distance,
case
when duration like 'null' then ' ' 
when duration like '%mins' then trim('mins' from duration)
when duration like '%minutes' then trim('minutes' from duration)
when duration like '%minute' then trim('minute' from duration)
else duration 
end as duration,
case 
when cancellation like '%NaN' then ' ' 
when cancellation like '%null' then ' ' 
else cancellation 
end as cancellation
from pizza_runner.runner_orders;
drop table pizza_runner.runner_orders_temp;

select* from pizza_runner.runner_orders_temp;


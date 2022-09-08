create schema dannys_dinner;
  
  create table dannys_dinner.sales(
  customer_id varchar(1),
  order_date date,
  product_id int);

  insert into dannys_dinner.sales(customer_id, order_date,product_id)
  values
 ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
  select* from dannys_dinner.sales;
  
  create table dannys_dinner.menu(
  product_id int,
  product_name varchar(10),
  price int);
  
  insert into dannys_dinner.menu(product_id, product_name, price)
  values
 ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  select*from dannys_dinner.menu;
  
  create table dannys_dinner.members (
  customer_id VARCHAR(1), 
  join_date DATE);
  
  
  insert into dannys_dinner.members(customer_id,join_date)
  values
  ('A','2021-01-07'),
  ('B','2021-01-09');
  
  select* from dannys_dinner.members;
  
  
  
  #CASE STUDY QUESTIONS
  #1. What is the total amount each customer spent at the restaurant?
  select sales.customer_id, sum(price) as total_sales
  from dannys_dinner.sales as sales
  join dannys_dinner.menu as menu
  on sales.product_id=menu.product_id
  group by customer_id;
  
  #2. How many days has each customer visited the restaurant?
  select sales.customer_id, count(distinct(order_date)) as days_visited
  from dannys_dinner.sales as sales
  group by customer_id;
  
  #3. What was the first item from the menu purchased by each customer?
#ranking the order_date 
# row number is a function that assigns a sequential integer to each row within the partition
# using dense_rank() instead of row_number

with ordered_sales as(
select customer_id, product_name, order_date,
dense_rank() over(partition by sales.customer_id
order by sales.order_date) as Ranks
from dannys_dinner.sales as sales
join dannys_dinner.menu as menu
on sales.product_id= menu.product_id)

select customer_id, product_name
from ordered_sales
where ranks=1
group by customer_id, product_name;
  
  #4. What is the most purchased item on the menu and how many times was it purchased by all customers?
  
  select  (count(sales.customer_id)) as most_purchased, product_name
  from dannys_dinner.sales as sales
  join dannys_dinner.menu as menu
  on sales.product_id= menu.product_id
group by sales.product_id, menu.product_name
order by most_purchased desc;

#5. Which item was the most popular for each customer?

with popular_food as(
select count(menu.product_id) as order_count, sales.customer_id, menu.product_name,
dense_rank() over(partition by sales.customer_id
order by count(sales.customer_id) desc) as Ranks
from dannys_dinner.menu as menu
join dannys_dinner.sales as sales
on sales.product_id= menu.product_id
group by sales.customer_id,menu.product_name)

select customer_id, product_name, order_count
from popular_food
where ranks=1;

 #6. Which item was purchased first by the customer after they became a member?
 
 with member_customer as(
 select members.join_date , sales.product_id, sales.customer_id, sales.order_date,
 dense_rank() over(partition by sales.customer_id
 order by sales.order_date ) as Ranks
 from dannys_dinner.sales as sales
 join dannys_dinner.members as members
 on sales.customer_id= members.customer_id
 where sales.order_date>= members.join_date)
 
 select s2.customer_id, menu.product_name, s2.order_date
 from member_customer s2
 join dannys_dinner.menu as menu
 on s2.product_id= menu.product_id
 where Ranks=1;
 
 #7. Which item was purchased just before the customer became a member?
 
 with member_customer as(
 select members.join_date , sales.product_id, sales.customer_id, sales.order_date,
 dense_rank() over(partition by sales.customer_id
 order by sales.order_date desc) as Ranks
 from dannys_dinner.sales as sales
 join dannys_dinner.members as members
 on sales.customer_id= members.customer_id
 where sales.order_date < members.join_date)
 
 select s2.customer_id, menu.product_name, s2.order_date
 from member_customer as s2
 join dannys_dinner.menu as menu
 on s2.product_id= menu.product_id
 where Ranks=1;
 
 #8. What is the total items and amount spent for each member before they become a member?
 
 select sales.customer_id, count(sales.product_id) as total_items, sum(menu.price)as total_price
 from dannys_dinner.sales as sales
 join dannys_dinner.menu as menu
 on sales.product_id= menu.product_id
 join dannys_dinner.members as members
 on sales.customer_id=members.customer_id
 where sales.order_date < members.join_date
 group by sales.customer_id;
 
 #9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier- how many points would each customer have?
 
#To create conditional statement use- case when

with customer_points as(
select*, 
case
	when menu.product_id=1 then menu.price*20 
	else price*10
end as points
from dannys_dinner.menu as menu)
select sales.customer_id, sum(p.points) as total_points
from customer_points as p
join dannys_dinner.sales as sales
on sales.product_id=p.product_id 
group by customer_id;

#10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

with customer_points as(
select sales.customer_id, sales.order_date, members.join_date,
date(members.join_date) as valid_date,
sales.product_id,
menu.price,
case
when sales.product_id=1 then menu.price*20
when sales.product_id != 1 and (sales.order_date between members.join_date and date(members.join_date))
then menu.price*20
else menu.price*10
end as points
from dannys_dinner.sales as sales
join dannys_dinner.members as members
on sales.customer_id= members.customer_id
join dannys_dinner.menu as menu
on sales.product_id= menu.product_id
where sales.order_date<= '2021-01-31' )

select c.customer_id, sum(points) as total_points
from customer_points as c
group by customer_id;

#Bonus questions 1

select sales.customer_id, sales.order_date, menu.price,menu.product_name,
case 
when members.join_date<=sales.order_date then 'Y'
else 'N'
end as members
from dannys_dinner.sales as sales
left join dannys_dinner.menu as menu
on sales.product_id=menu.product_id
left join dannys_dinner.members as members
on sales.customer_id= members.customer_id;





#Bonus questions 2

with ranking_values as(
select sales.customer_id, sales.order_date, menu.price,menu.product_name,
case 
when members.join_date<=sales.order_date then 'Y'
else 'N'
end as members
from dannys_dinner.sales as sales
left join dannys_dinner.menu as menu
on sales.product_id=menu.product_id
left join dannys_dinner.members as members
on sales.customer_id= members.customer_id
)
select*,
case 
when members= 'N' then 'Null'
else dense_rank() over(partition by sales.customer_id, members
order by sales.order_Date) end as Ranking
from ranking_values;

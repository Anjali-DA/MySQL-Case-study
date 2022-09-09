# 💡Case Study Questions- Danny's Dinner
**🦋1. What is the total amount each customer spent at the restaurant?**
``` SQL
  select sales.customer_id, sum(price) as total_sales
  from dannys_dinner.sales as sales
  join dannys_dinner.menu as menu
  on sales.product_id=menu.product_id
  group by customer_id;
  ```
  ![d1](https://user-images.githubusercontent.com/98269318/189200027-6ddc0bb0-d2fd-4eef-9f7e-d84a768eaee6.png)
  
**Ans**: Total amount each customer spent at the restaurant:
- Customer A spents **$76** 
- Customer B spents **$74**
- Customer C spents **$36** 

**🦋2. How many days has each customer visited the restaurant?**
``` SQL
  select sales.customer_id, count(distinct(order_date)) as days_visited
  from dannys_dinner.sales as sales
  group by customer_id;
  ```
  ![d2](https://user-images.githubusercontent.com/98269318/189201332-2bf5d4bf-9933-4fea-8757-4f5d7b5b63e8.png)

**Ans**: No. of days each customer visited the restaurant:
- Customer A visted **4** days
- Customer B visited **6** days
- Customer C visited **2** days

**🦋3. What was the first item from the menu purchased by each customer?**
``` SQL
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
```
![d3](https://user-images.githubusercontent.com/98269318/189202389-d3453a51-5f87-44a8-81ae-190c2e092ba5.png)

**Ans**: First item from the menu purchased by each customer:
- Customer A bought **Sushi & Curry**
- Customer B bought **Curry**
- Customer C bought **Ramen**

**🦋4. What is the most purchased item on the menu and how many times was it purchased by all customers?**
``` SQL
  select  (count(sales.customer_id)) as most_purchased, product_name
  from dannys_dinner.sales as sales
  join dannys_dinner.menu as menu
  on sales.product_id= menu.product_id
  group by sales.product_id, menu.product_name
  order by most_purchased desc;
  ```
  ![q4](https://user-images.githubusercontent.com/98269318/189362065-151285c8-56c1-4e7c-97e2-59fbc13b61ff.png)

**Ans**: Most item purchased item on the menu by all the customers:
- Ramen was purchased **8** times
- Curry was purchased **4** times
- Sushi was purchased **3** times

  **🦋5. Which item was the most popular for each customer?**
  ``` SQL
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
  ```
  ![q5](https://user-images.githubusercontent.com/98269318/189363855-f978c973-0da1-4ad1-b2ef-07f035e7498e.png)
  
  **Ans**: Most popular items for each customer:
  - Customer A bought **3 ramen**.
  - Customer B bought **2 curry, 2 sushi, 2 ramen**
  - Customer C bought **3 ramen**

**🦋6.Which item was purchased first by the customer after they became a member?**
``` SQL
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
```
![q6](https://user-images.githubusercontent.com/98269318/189366494-08f67137-9e56-480d-aa8e-a8ef6705fba9.png)

**Ans**: First item purchased by the customers after they became a member:
- Customer A bought **Sushi**
- Customer B bought **Curry**

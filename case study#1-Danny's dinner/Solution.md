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

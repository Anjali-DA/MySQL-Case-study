## Case study 1- Danny's Dinner

Q1. What is the total amount each customer spent at the restaurant?

**Ans**: Use **sum**, **join** & **group by** to solve this query

| **customer_id**  | **total_sales**   | 
| -------------    |:-------------:    | 
| A                | 76                |
| B                | 74                | 
| C                | 36            | 

Q2. How many days has each customer visited the restaurant?

**Ans**: Use **count** & **group by** to solve this query

| customer_id      | days_visited  | 
| -------------    |:-------------:| 
| A                | 4             |
| B                | 6             | 
| C                | 2             | 

Q3. What was the first item from the menu purchased by each customers?

**Ans** : •Use **dense_rank()**, **group by**, **order by** and **with clause**.
          •**row_number**- row number is a function that assigns a sequential integer to each row within the partition. 
          •Instead of **row_number**, we will use dense_rank

| customer_id      | product_name  | 
| -------------    |:-------------:| 
| A                | sushi         |
| A                | curry         | 
| B                | curry         | 
| C                | ramen         | 

Q4. What is the most purchased item on the menu and how many times was it purchased by all customers?

**Ans**- Use **count**, & **join**, **group by** & **order by** to solve the query

| product_name     | most_purchased| 
| -------------    |:-------------:| 
| ramen            | 8             |
| curry            | 4             | 
| sushi            | 3             | 

Q5. Which item was the most popular for each customer?

**Ans:**
•Use **with clause** for creating a sub &
•Other functions- **join**, **group by** & **order by**

| customer_id    | product_name  |order_count|
| -------------  |:-------------:|:---------:|
|A               | ramen         |3          |
|B               | curry         |2          |
|B               | sushi         |2          |
|B               | ramen         |2          |
|C               | ramen         |3          |

Q6. Which item was purchased first by the customer after they became a member?

**Ans**- Use **dense_rank()**, **join**, & **with clause** to solve the query

|customer_id| product_id |order_id  |
| ----------| :---------:|:-------: |
|A          | sushi      |2021-01-11|
|B          | curry      |2021-01-04|

Q7. Which item was purchased just before the customer became a member?

Ans- Use **dense_rank()**, **join**, & **with clause** to solve the query

|customer_id| product_name |order_id   |
| ----------| :-----------:|:-------:  |
|A          | sushi        |2021-01-11 |
|B          | sushi        |2021-01-04 |
|A          | curry        |2021-01-01 |

Q8. What is the total items and amount spent for each member before they become a member?

Ans- Use **join**, **group by**, **count**, **sum** & **logical operators** to solve the query

|customer_id| total_id   |total_price |
| ----------| :---------:|:---------: |
|B          | 3          |40          |
|A          | 2          |25          |

Q9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier- how many points would each customer have?

**Ans**- Use with clause, case-when, join, sum & group 

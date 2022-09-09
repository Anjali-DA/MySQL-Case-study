# 💡Case Study Questions

**⚡1.How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)**
``` SQL
select extract(week from ru.registration_date) as registration_week,  count(runner_id) as runner_signed_up
from pizza_runner.runners as ru
group by registration_week;
```
![b1](https://user-images.githubusercontent.com/98269318/189396609-2007ca62-8e44-44dc-a83c-f7d91b2a7212.png)

*Note: The output is given as week0, week1, week2, so for better understanding let us take week1, week2 & week3
**Ans**: Runners signed up for each 1 week period:
- In week 1 & week 3, one runner signed up
- In week 2, two runners signed up


<!--
title: 'mod3-ordenacao-agrupamentos-matematica.md'
author: 'Elias Albuquerque'
created: '2024-02-18'
update: '2024-02-18'
-->

# MySQL - Ordenacao, agrupamento e funções matemáticas mais usadas

- [1 - Ordene seus resultados com Order By](#1---ordene-seus-resultados-com-order-by)
- [2 - Como limitar resultados, retornar quantidade X de linhas](#2---como-limitar-resultados-retornar-quantidade-x-de-linhas)
- [3 - Agregue valores com as funções Sum - Avg - Min - Max](#3---agregue-valores-com-as-funções-sum---avg---min---max)
- [4 - Count - Descubra quantos resultados são retornados de algo](#4---count---descubra-quantos-resultados-são-retornados-de-algo)
- [5 - Agrupe resultados através do Group by](#5---agrupe-resultados-através-do-group-by)
- [6 - Having](#6---having)


## 1 - Ordene seus resultados com Order By

Modelo:

```sql
SELECT coluna1, coluna2, coluna_n
FROM tabela
ORDER BY coluna1, coluna_n ASC | DESC
```

Ordenando dados:

```sql
-- ordenar o limite de credito em ordem decrescente
select customerName, creditLimit
from customers
order by creditLimit desc;

-- ordenar tanto por limite de credito quanto por nome do cliente
select customerName, creditLimit
from customers
order by creditLimit, customerName;

-- ordenar limite de credito decrescente e nome do cliente em ordem crescente
select customerName, creditLimit
from customers
order by creditLimit desc, customerName;
```


## 2 - Como limitar resultados, retornar quantidade X de linhas

Modelo:

```sql
SELECT *
FROM products
LIMIT 5;
```

Limitando resultados:

```sql
-- limitar visualizacao dos primeiros 5 produtos mais baratos
select *
from products
order by buyPrice
limit 5;

-- limitar visualizacao dos próximos 5 produtos mais baratos
select *
from products
order by buyPrice
limit 5 offset 5;
```

Desafio: retorne os 10 primeiros valores (amount), em ordem crescente da tabela payments.

```sql
select amount
from payments
order by amount
limit 10;
```

## 3 - Agregue valores com as funções Sum - Avg - Min - Max

```sql
-- valor mínimo
select min(amount) as 'valor mínimo'
from payments;

-- valor máximo
select max(amount) as 'valor máximo'
from payments;

-- valor médio
select avg(amount) as 'valor médio'
from payments;

-- soma dos valores
select sum(amount) as 'valor total'
from payments;
```

## 4 - Count - Descubra quantos resultados são retornados de algo

```sql
-- quantos dados registrado em customers:
select count(*) as dados
from customers;

-- quantos paises diferentes temos cadastrados na tabela customers:
select count(distinct country) as 'paises (qnt)'
from customers;

-- quantos clientes dos EUA temos cadastrados na tabela customers:
select count(*) as 'EUA (qnt)'
from customers
where country = 'USA';

-- quantos clientes da Indonésia temos cadastrados na tabela customers:
select count(*) as 'Indonésia (qnt)'
from customers
where country = 'Indonesia';

-- quantas motos temos cadastradas na tabela products:
select count(*) as motos
from products
where productLine = 'motorcycles';

-- quantos representantes de venda temos na tabela employees:
select count(*) as 'sales rep'
from employees
where jobTitle = 'sales rep'
```

## 5 - Agrupe resultados através do Group by

```sql
-- soma total:
select sum(amount) as 'total'
from payments;

-- soma total por clientes:
select customerNumber, sum(amount) as 'total'
from payments
group by customerNumber;

-- média do valor de compra por linha de produto:
select productLine as 'linha de produto', avg(buyPrice) as 'média: valor de compra'
from products
group by productLine;

-- quantos registros de cada país tem na tabela customers:
select count(*) as 'quantidade' , country as 'paises'
from customers
group by country;

-- quantos registros de cada país tem na tabela products:
select productLine as 'linha de produtos', count(*) as 'quantidade'
from products
group by productLine;
```

## 6 - Having

```sql
-- selecionar clientes com media total acima de 50k da tabela payments
select customerNumber, avg(amount) as media_total
from payments
group by customerNumber
having media_total > 50000;

-- selecionar clientes com media total entre dois valores da tabela payments
select customerNumber, avg(amount) as media_total
from payments
group by customerNumber
having media_total between 50000 and 70000;

-- na tabela products, retorne os totais do estoque de cada categoria de produto, onde o total esta entre 20k e 70k:
select productLine as 'linha_produto', sum(quantityInStock) as 'qnt_estoque'
from products
group by linha_produto
having qnt_estoque between 20000 and 70000;
```
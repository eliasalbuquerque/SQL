<!--
title: 'mod4-unir-dados-de-varias-tabelas.md'
author: 'Elias Albuquerque'
created: '2024-02-18'
update: '2024-02-18'
-->


# Módulo 4 - Como UNIR dados de VÁRIAS tabelas


- [1 - Como unir tabelas com INNER JOIN](#1---como-unir-tabelas-com-inner-join)
- [2 - Using - Hack para fazer JOINS mais rápidos](#2---using---hack-para-fazer-joins-mais-rápidos)
- [3 - Inner Join - Na prática](#3---inner-join---na-prática)
- [4 - Left Join - Na prática](#4---left-join---na-prática)
- [5 - Right join - Na prática](#5---right-join---na-prática)
- [6 - Criando informações a partir de múltiplos JOINS](#6---criando-informações-a-partir-de-múltiplos-joins)
- [7 - Self Join - Como unir usando a MESMA tabela](#7---self-join---como-unir-usando-a-mesma-tabela)
- [8 - Filtre dados mais diretamente com um SUBQUERY](#8---filtre-dados-mais-diretamente-com-um-subquery)
- [9 - SUBQUERY no FROM](#9---subquery-no-from)
- [10 - SUBQUERY no WHERE](#10---subquery-no-where)
- [11 - UNION - Una múltiplos resultados de forma SIMPLES!](#11---union---una-múltiplos-resultados-de-forma-simples)


## 1 - Como unir tabelas com INNER JOIN

```sql
select *
from tabelaA as a
join tabelab as b
on a.coluna_comum = b.coluna_comum;

-- combinar dados entre duas tabelas 'employees' e 'offices' com uma mesma 
-- coluna:
select * from employees;
select * from offices;

-- na tabela employees apresenta o codigo do 'officeCode' e na tabela offices 
-- apresenta as cidades de cada 'officeCode'.
-- selecionando os dados de cada tabela e combinando de acordo com a coluna 
-- 'officeCode', temos:
select e.employeeNumber, e.firstName, e.officeCode, o.city, o.addressLine1
from employees as e
join offices as o
on e.officeCode = o.officeCode;

-- combinar os seguintes dados: orderNumber, customerNumber, customerName, phone:
select * from company.orders;
select * from customers;
select o.orderNumber, o.customerNumber, c.customerName, c.phone
from orders as o
join customers as c
on o.customerNumber = c.customerNumber;

-- customerName, customerNumber, checkNumber, amount
select c.customerName, c.customerNumber, p.checkNumber, p.amount
from customers as c
join payments as p
on c.customerNumber = p.customerNumber;
```

## 2 - Using - Hack para fazer JOINS mais rápidos

```sql
-- using pode ser usado quando o nome das colunas entre duas tabelas é o mesmo
select e.employeeNumber, e.firstName, e.officeCode, o.city, o.addressLine1
from employees as e
join offices as o
using (officeCode);
```

## 3 - Inner Join - Na prática

Combinar os valores das tabelas com base em uma coluna em comum.

## 4 - Left Join - Na prática

Usar quando tem a necessidade de listar todos os dados de uma tabela a esquerda, 
mesmo que não exista valores correspondentes entre determinados dados.

## 5 - Right join - Na prática

Usar quando tem a necessidade de listar todos os dados de uma tabela a esquerda, 
mesmo que não exista valores correspondentes entre determinados dados.

## 6 - Criando informações a partir de múltiplos JOINS

Queremos unir informações da compra da tabela 'orders', cliente de 'customers', 
e funcionário responsável de 'employees'.

```sql
-- orderNumber, customerName, firstName, jobTitle
select * from orders; -- customerNumber
select * from customers; -- customerNumber, salesRepEmployeeNumber
select * from employees; -- employeeNumber

select o.orderNumber, c.customerName, e.firstName, e.jobTitle
from orders o
join customers c
using (customerNumber)
join employees e
on e.employeeNumber = c.salesRepEmployeeNumber
```

Queremos unir o número do pedido com o nome do cliente que fez aquele pedido, 
'orderNumber (orders) + customerName (customers).
Após isso, criar uma query para saber quem foi o representante de vendas 
reponsável por estes clientes, 'orderNumber (orders) + customerName (customer) + 
firstName (employee):

```sql
-- numero do pedido (orderNumber)
select * from orders; 
-- nome do cliente (customerName)
select * from customers;
-- representante de vendas (firstName)
select * from employees;

-- em comum: customerNumber
-- em comum: employeeNumber (employees) + salesRepEmployeeNumber (customers)

select o.orderNumber, c.customerName, e.firstName
from orders as o
join customers as c
using (customerNumber)
join employees as e
on e.employeeNumber = c.salesRepEmployeeNumber;
```

Monte uma query qye retorna o seguinte resultado:

- o nome do cliente, sua cidade, nome do produto e quantidade

```sql
select * from clientes; -- nome cliente (Nome) e cidade (Cidade)| ID --> ClienteID
select * from pedidos; -- quantidade (Quantidade) | ClienteID, ProdutoID
select * from produtos; -- nome do produto (Nome) ID --> ProdutoID

select c.Nome as 'Cliente', c.Cidade, pr.Nome as 'Nome produtos', p.Quantidade as 'Qnt. produtos'
from clientes as c
join pedidos as p
on c.ID = p.ClienteID
join produtos as pr
on pr.ID = p.ProdutoID
order by Cliente;
```

![alt text](image.png)

## 7 - Self Join - Como unir usando a MESMA tabela

Montar uma query que selecione o numero do gestor, o nome do gestor, o numero 
do funcionario e o nome do funcionario.

```sql
select * from employees;

-- employeeNumber, firstName, reportsTo
select gestor.employeeNumber as 'ID Gestor', gestor.firstName as 'Nome Gestor', func.employeeNumber as 'ID Funcionario', func.firstName as 'Nome Funcionario'
from employees as gestor
join employees as func
on gestor.employeeNumber = func.reportsTo;

-- quem é o gestor com maior numero de funcionarios
select g.employeeNumber as 'gestor', g.firstName as 'nome_gestor', count(f.employeeNumber) as 'qnt_funcionarios'
from employees as g
join employees as f
on g.employeeNumber = f.reportsTo
group by g.employeeNumber, g.firstName
order by qnt_funcionarios desc
```

## 8 - Filtre dados mais diretamente com um SUBQUERY

```sql
-- modo subquery
select customerNumber, customerName,
	(select firstName
    from employees
    where employees.employeeNumber = customers.salesRepEmployeeNumber) as firstName
from customers
order by customerNumber;

-- comparacao com o modo join
select c.customerNumber, c.customerName, e.firstName
from customers as c
join employees as e
on c.salesRepEmployeeNumber = e.employeeNumber
order by c.customerNumber;

-- outro exemplo
select orderNumber, 
	(select customerName
    from customers
    where customers.customerNumber = orders.customerNumber) as customerName
from orders
```

## 9 - SUBQUERY no FROM

Não recomendável

## 10 - SUBQUERY no WHERE

```sql
select *
from employees
where officeCode in (
	select officeCode
    from offices
    where country in ('USA','France','Japan'));

-- desafio: retorne pedidos (orderNumber[orders]) que tiveram mais que 30 
-- unidades (quantityOrdered[orderdetails]) vendidas em uma venda:
select * from orders;
select * from orderdetails;
    
select *
from orders
where orderNumber in (
	select orderNumber
    from orderdetails
    where quantityOrdered > 30);
```

## 11 - UNION - Una múltiplos resultados de forma SIMPLES!

```sql
-- removendo valores duplicados
select firstName
from employees
union 
select contactFirstName
from customers;
order by firstName

-- adicionando valores duplicados
select firstName
from employees
union all
select contactFirstName
from customers;
order by firstName
```
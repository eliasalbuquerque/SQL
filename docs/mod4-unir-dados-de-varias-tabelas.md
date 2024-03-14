<!--
title: 'mod4-unir-dados-de-varias-tabelas.md'
author: 'Elias Albuquerque'
created: '2024-02-18'
update: '2024-02-18'
-->


# Módulo 4 - Como UNIR dados de várias tabelas


- [1 - Como unir tabelas com INNER JOIN](#1---como-unir-tabelas-com-inner-join)
- [2 - USING - Hack para fazer JOINS mais rápidos](#2---using---hack-para-fazer-joins-mais-rápidos)
- [3 - INNER JOIN - Na prática](#3---inner-join---na-prática)
- [4 - Left JOIN - Na prática](#4---left-join---na-prática)
- [5 - Right JOIN - Na prática](#5---right-join---na-prática)
- [6 - Criando informações a partir de múltiplos JOINS](#6---criando-informações-a-partir-de-múltiplos-joins)
- [7 - Self JOIN - Como unir usando a MESMA tabela](#7---self-join---como-unir-usando-a-mesma-tabela)
- [8 - Filtre dados mais diretamente com um SUBQUERY](#8---filtre-dados-mais-diretamente-com-um-subquery)
- [9 - SUBQUERY no FROM](#9---subquery-no-from)
- [10 - SUBQUERY no WHERE](#10---subquery-no-where)
- [11 - UNION - Una múltiplos resultados de forma SIMPLES!](#11---union---una-múltiplos-resultados-de-forma-simples)


## 1 - Como unir tabelas com INNER JOIN

```sql
SELECT *
FROM tabelaA as a
JOIN tabelab as b
ON a.coluna_comum = b.coluna_comum;

-- combinar dados entre duas tabelas 'employees' e 'offices' com uma mesma 
-- coluna:
SELECT * FROM employees;
SELECT * FROM offices;

-- na tabela employees apresenta o codigo do 'officeCode' e na tabela offices 
-- apresenta as cidades de cada 'officeCode'.
-- selecionando os dados de cada tabela e combinando de acordo com a coluna 
-- 'officeCode', temos:
SELECT e.employeeNumber, e.firstName, e.officeCode, o.city, o.addressLine1
FROM employees as e
JOIN offices as o
ON e.officeCode = o.officeCode;

-- combinar os seguintes dados: orderNumber, customerNumber, customerName, phone:
SELECT * FROM company.orders;
SELECT * FROM customers;
SELECT o.orderNumber, o.customerNumber, c.customerName, c.phone
FROM orders as o
JOIN customers as c
ON o.customerNumber = c.customerNumber;

-- customerName, customerNumber, checkNumber, amount
SELECT c.customerName, c.customerNumber, p.checkNumber, p.amount
FROM customers as c
JOIN payments as p
ON c.customerNumber = p.customerNumber;
```


## 2 - USING - Hack para fazer JOINS mais rápidos

```sql
-- USING pode ser usado quando o nome das colunas entre duas tabelas é o mesmo
SELECT e.employeeNumber, e.firstName, e.officeCode, o.city, o.addressLine1
FROM employees as e
JOIN offices as o
USING (officeCode);
```


## 3 - INNER JOIN - Na prática

Combinar os valores das tabelas com base em uma coluna em comum.


## 4 - Left JOIN - Na prática

Usar quando tem a necessidade de listar todos os dados de uma tabela a esquerda, 
mesmo que não exista valores correspondentes entre determinados dados.


## 5 - Right JOIN - Na prática

Usar quando tem a necessidade de listar todos os dados de uma tabela a esquerda, 
mesmo que não exista valores correspondentes entre determinados dados.


## 6 - Criando informações a partir de múltiplos JOINS

Queremos unir informações da compra da tabela 'orders', cliente de 'customers', 
e funcionário responsável de 'employees'.

```sql
-- orderNumber, customerName, firstName, jobTitle
SELECT * FROM orders; -- customerNumber
SELECT * FROM customers; -- customerNumber, salesRepEmployeeNumber
SELECT * FROM employees; -- employeeNumber

SELECT o.orderNumber, c.customerName, e.firstName, e.jobTitle
FROM orders o
JOIN customers c
USING (customerNumber)
JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
```

Queremos unir o número do pedido com o nome do cliente que fez aquele pedido, 
'orderNumber (orders) + customerName (customers).
Após isso, criar uma query para saber quem foi o representante de vendas 
responsáveis por estes clientes, 'orderNumber (orders) + customerName (customer) + 
firstName (employee):

```sql
-- numero do pedido (orderNumber)
SELECT * FROM orders; 
-- nome do cliente (customerName)
SELECT * FROM customers;
-- representante de vendas (firstName)
SELECT * FROM employees;

-- em comum: customerNumber
-- em comum: employeeNumber (employees) + salesRepEmployeeNumber (customers)

SELECT o.orderNumber, c.customerName, e.firstName
FROM orders as o
JOIN customers as c
USING (customerNumber)
JOIN employees as e
ON e.employeeNumber = c.salesRepEmployeeNumber;
```

Monte uma query que retorna o seguinte resultado:

- o nome do cliente, sua cidade, nome do produto e quantidade

```sql
SELECT * FROM clientes; -- nome cliente (Nome) e cidade (Cidade)| ID --> ClienteID
SELECT * FROM pedidos; -- quantidade (Quantidade) | ClienteID, ProdutoID
SELECT * FROM produtos; -- nome do produto (Nome) ID --> ProdutoID

SELECT c.Nome as 'Cliente', c.Cidade, pr.Nome as 'Nome produtos', p.Quantidade as 'Qnt. produtos'
FROM clientes as c
JOIN pedidos as p
ON c.ID = p.ClienteID
JOIN produtos as pr
ON pr.ID = p.ProdutoID
ORDER BY Cliente;
```


## 7 - Self JOIN - Como unir usando a MESMA tabela

Montar uma query que selecione o numero do gestor, o nome do gestor, o numero 
do funcionario e o nome do funcionario.

```sql
SELECT * FROM employees;

-- employeeNumber, firstName, reportsTo
SELECT gestor.employeeNumber as 'ID Gestor', gestor.firstName as 'Nome Gestor', func.employeeNumber as 'ID Funcionario', func.firstName as 'Nome Funcionario'
FROM employees as gestor
JOIN employees as func
ON gestor.employeeNumber = func.reportsTo;

-- quem é o gestor com maior numero de funcionarios
SELECT g.employeeNumber as 'gestor', g.firstName as 'nome_gestor', count(f.employeeNumber) as 'qnt_funcionarios'
FROM employees as g
JOIN employees as f
ON g.employeeNumber = f.reportsTo
group by g.employeeNumber, g.firstName
ORDER BY qnt_funcionarios desc;
```


## 8 - Filtre dados mais diretamente com um SUBQUERY

```sql
-- modo subquery
SELECT customerNumber, customerName,
	(SELECT firstName
    FROM employees
    WHERE employees.employeeNumber = customers.salesRepEmployeeNumber) as firstName
FROM customers
ORDER BY customerNumber;

-- comparacao com o modo JOIN
SELECT c.customerNumber, c.customerName, e.firstName
FROM customers as c
JOIN employees as e
ON c.salesRepEmployeeNumber = e.employeeNumber
ORDER BY c.customerNumber;

-- outro exemplo
SELECT orderNumber, 
	(SELECT customerName
    FROM customers
    WHERE customers.customerNumber = orders.customerNumber) as customerName
FROM orders
```


## 9 - SUBQUERY no FROM

Não recomendável


## 10 - SUBQUERY no WHERE

```sql
SELECT *
FROM employees
WHERE officeCode in (
	SELECT officeCode
    FROM offices
    WHERE country in ('USA','France','Japan'));

-- desafio: retorne pedidos (orderNumber[orders]) que tiveram mais que 30 
-- unidades (quantityOrdered[orderdetails]) vendidas em uma venda:
SELECT * FROM orders;
SELECT * FROM orderdetails;
    
SELECT *
FROM orders
WHERE orderNumber in (
	SELECT orderNumber
    FROM orderdetails
    WHERE quantityOrdered > 30);
```


## 11 - UNION - Una múltiplos resultados de forma SIMPLES!

```sql
-- removendo valores duplicados
SELECT firstName
FROM employees
UNION 
SELECT contactFirstName
FROM customers;
ORDER BY firstName

-- adicionando valores duplicados
SELECT firstName
FROM employees
UNION ALL
SELECT contactFirstName
FROM customers;
ORDER BY firstName
```
<!--
title: 'mod2-extraindo-dados.md'
author: 'Elias Albuquerque'
created: '2024-02-18'
update: '2024-03-14'
-->

# Módulo 2 - Como EXTRAIR dados do seu Banco de dados!

- [1 - Encontre dados usando Select e Distinct](#1---encontre-dados-usando-select-e-distinct)
- [2 - Aprenda filtrar resultados com Where](#2---aprenda-filtrar-resultados-com-where)
- [3 - Inclua mais condições com menos através do In](#3---inclua-mais-condições-com-menos-através-do-in)
- [4 - Between - Encontre dados entre uma faixa de valores](#4---between---encontre-dados-entre-uma-faixa-de-valores)
- [5 - LIKE - Encontre dados com base em parte do Texto!](#5---like---encontre-dados-com-base-em-parte-do-texto)


## 1 - Encontre dados usando Select e Distinct

```sql
-- seleciona banco de dados
USE company;

-- selecionar todos os dados da tabela
SELECT *
FROM customers;

-- selecionar dados de colunas especificas da tabela
SELECT phone, city
FROM customers;

-- DESAFIO: retornar apenas customerName, state
SELECT customerName, state
FROM customers;

-- selecionar dados sem restricao de duplicidade
SELECT contactFirstName
FROM customers;

-- selecionar apenas dados sem duplicidade (unicos)
SELECT DISTINCT contactFirstName
FROM customers;
```


## 2 - Aprenda filtrar resultados com Where

```sql
-- filtrar dados por texto
SELECT *
FROM customers
WHERE state = 'CA';

-- filtrar por valores
SELECT *
FROM customers
WHERE creditLimit = 90700;

-- filtrar com mais de uma condicao
SELECT *
FROM customers
WHERE state = 'CA' and creditLimit > 50000;

-- filtrar dados por faixa de valores
SELECT *
FROM customers
WHERE creditLimit >= 10000 and creditLimit <= 50000;

-- selecionar dados por exclusao de pesquisa
SELECT *
FROM customers
WHERE country <> 'USA';

-- DESAFIO: Va ate a tabela 'employees' e retorne todos os dados cadastrados 
-- que nao sao 'Sales Rep'
SELECT *
FROM employees
WHERE jobTitle <> 'Sales Rep';
```

Maneiras mais comuns de filtrar os dados:

```output
=       | IGUAL
>       | MAIOR QUE
<       | MENOR QUE
>=      | MAIOR OU IGUAL
<=      | MANOR OU IGUAL
<>      | DIFERENTE DE
AND     | OPERADOR LOGICO E
OR      | OPERADOR LOGICO OU
```


## 3 - Inclua mais condições com menos através do In

```sql
-- retornar todos clientes dos EUA, Portugal e Australia
SELECT *
FROM customers
WHERE country in ('EUA', 'Portugal', 'Australia');

-- DESAFIO: Precisamos do nome do contato, o telefone e enderesso de todos os 
-- clientes que moram no estado da California e Nova York da tabela 'customers'
SELECT contactFirstName, phone, addressLine1
FROM customers
WHERE state in ('CA', 'NY');
```


## 4 - Between - Encontre dados entre uma faixa de valores

```sql
-- 4 - Between - Encontre dados entre uma faixa de valores
-- selecionar dados entre uma faixa de valores
SELECT *
FROM customers
WHERE creditLimit BETWEEN 10000 and 50000;

-- DESAFIO: Monte uma query que retorna da tabela 'products', o nome do produto 
-- e a quantidade em estoque dos produtos que possuem entre 6 a 7 mil unidades
SELECT productName, quantityInStock
FROM products
WHERE quantityInStock BETWEEN 6000 and 7000;
```


## 5 - LIKE - Encontre dados com base em parte do Texto!

```sql
-- buscar por parte da informacao do dado

-- %<parte do dado> = nao sei o que vem antes
-- <parte do dado>% = nao sei o que vem depois
SELECT *
FROM customers
WHERE customerName
LIKE '%Toys%';

-- buscar por inicio do dado
SELECT *
FROM customers
WHERE customerName
LIKE 'Dragon%';

-- buscar por fim do dado
SELECT *
FROM customers
WHERE customerName
LIKE '%Classics';
```

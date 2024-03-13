<!--
title: 'mysql.md'
author: 'Elias Albuquerque'
created: '2024-02-18'
update: '2024-02-18'
-->

# MySQL - Extraindo dados

1. Selecionar determinada coluna, de uma tabela, onde na coluna tenha os seguintes dados:

```sql
SELECT <nome_das_colunas>
FROM <tabelas>
WHERE <coluna> = 'dados'
```

- **nome_das_colunas**: Uma ou varias separadas por vírgula;
- **tabelas**: Especificar tabela da pesquisa;
- **dados**: Número, texto ou valor contido na coluna;

2. Selecionar todas as colunas da tabela "customers", onde coluna "state" seja igual a "CA" e coluna "creditLimit" seja maior que 50k:

```sql
SELECT *
FROM customers
WHERE state = 'CA' AND 'creditLimit' > 50000;
```

```output
10 row(s) returned
```

3. Listar todos os clientes que tem limites de crédito entre 10k e 50k:

```sql
SELECT *
FROM customers
WHERE creditLimit >= '10000' AND creditLimit <= '50000';
```

```output
13 row(s) returned
```

4. Retorne uma lista de todos os clientes que não estao nos Estados Unidos:

```sql
SELECT *
FROM customers
WHERE country <> 'USA'
```

```output
86 row(s) returned
```

5. Retorne todos os dados cadastrados da tabela "employees" de todos os funcionários que não são "Sales Rep":

```sql
SELECT *
FROM employees
WHERE jobTitle <> 'Sales Rep'
```

```output
6 row(s) returned
```

7. Maneiras de filtrar os dados:

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

8. Usando o **IN** para filtrar dados:

Ex. Filtrar dados que dos seguintes países: EUA, Portugal e Australia

```sql
-- modo convencional
SELECT *
FROM customers
WHERE country = 'EUA' OR country = 'Portugal' OR country = 'Australia';

-- usando "IN"
SELECT *
FROM customers
WHERE country IN ('EUA', 'Portugal', 'Australia');
```

9. Retorne o primeiro nome do contato, telefone e endereço de todos os clientes que moram no estado da California ou Nova York da tabela customers:

```sql
SELECT contactFirstName, phone, addressLine1
FROM customers
WHERE state IN ('CA', 'NY');
```

```output
17 row(s) returned
```

10.  Usando o **BETWEEN** para filtrar dados entre dois valores ou condições, monte um *query* que retorna da tabela 'products' o 'productName' e 'quantityInStock' dos produtos que possuem entre 6 a 7 mil unidades em estoque ('quantityInStock):

```sql
SELECT productName, quantityInStock
FROM products
WHERE quantityInStock between 6000 and 7000;
```

```output
13 row(s) returned
```

11. Usando o **LIKE (%)** para filtrar dados:

```sql
-- qualquer dado que contenha:
SELECT *
FROM customers
WHERE customerName
LIKE '%Toys%';

-- qualquer dado que inicie com:
SELECT *
FROM customers
WHERE customerName
LIKE 'Dragon%';

-- qualquer dado que finalize com:
SELECT *
FROM customers
WHERE customerName
LIKE '%Classics';
```

```output
4 row(s) returned
1 row(s) returned
1 row(s) returned
```

12. Encontre na tabela products o produto que tem 'Guzzi' no nome:

```sql
SELECT *
FROM products
WHERE productName
LIKE '%Guzzi%';
```

13. Encontre na tabela products o produto que finaliza com 'Falcon':

```sql
SELECT *
FROM products
WHERE productName
LIKE '%Falcon';
```

14. Encontre na tabela products o produto que inicia com 'Boeing':

```sql
SELECT *
FROM products
WHERE productName
LIKE 'Boeing%';
```

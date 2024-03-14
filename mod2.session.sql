-- 1
-- seleciona banco de dados
USE company;
-- selecionar todos os dados da tabela
SELECT *
FROM customers;
-- selecionar dados de colunas especificas da tabela
SELECT phone,
    city
FROM customers;
-- DESAFIO: retornar apenas customerName, state
SELECT customerName,
    state
FROM customers;
-- selecionar dados sem restricao de duplicidade
SELECT contactFirstName
FROM customers;
-- selecionar apenas dados sem duplicidade (unicos)
SELECT DISTINCT contactFirstName
FROM customers;
-- 2 - Aprenda filtrar resultados com Where
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
WHERE state = 'CA'
    and creditLimit > 50000;
-- filtrar dados por faixa de valores *
SELECT *
FROM customers
WHERE creditLimit >= 10000
    and creditLimit <= 50000;
-- * pode ser utilizado BETWEEN (4)
-- selecionar dados por exclusao de pesquisa
SELECT *
FROM customers
WHERE country <> 'USA';
-- DESAFIO: Va ate a tabela 'employees' e retorne todos os dados cadastrados 
-- que nao sao 'Sales Rep'
SELECT *
FROM employees
WHERE jobTitle <> 'Sales Rep';
-- 3 - Inclua mais condições com menos através do In
-- retornar todos clientes dos EUA, Portugal e Australia
SELECT *
FROM customers
WHERE country in ('EUA', 'Portugal', 'Australia');
-- DESAFIO: Precisamos do nome do contato, o telefone e enderesso de todos os 
-- clientes que moram no estado da California e Nova York da tabela 'customers'
SELECT contactFirstName,
    phone,
    addressLine1
FROM customers
WHERE state in ('CA', 'NY');
-- 4 - Between - Encontre dados entre uma faixa de valores
-- selecionar dados entre uma faixa de valores
SELECT *
FROM customers
WHERE creditLimit BETWEEN 10000 and 50000;
-- DESAFIO: Monte uma query que retorna da tabela 'products', o nome do produto 
-- e a quantidade em estoque dos produtos que possuem entre 6 a 7 mil unidades
SELECT productName,
    quantityInStock
FROM products
WHERE quantityInStock BETWEEN 6000 and 7000;
-- 5 - LIKE - Encontre dados com base em parte do Texto!
-- buscar por parte da informacao do dado
-- %<parte do dado> = nao sei o que vem antes
-- <parte do dado>% = nao sei o que vem depois
SELECT *
FROM customers
WHERE customerName LIKE '%Toys%';
-- buscar por inicio do dado
SELECT *
FROM customers
WHERE customerName LIKE 'Dragon%';
-- buscar por fim do dado
SELECT *
FROM customers
WHERE customerName LIKE '%Classics';
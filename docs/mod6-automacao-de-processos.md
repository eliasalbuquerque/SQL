# Módulo 6 - Automação de Processos com ESTES conceitos

- [1 - Como criar visualizações auto-atualizáveis com VIEW](#1---como-criar-visualizações-auto-atualizáveis-com-view)
- [2 - Variáveis no SQL](#2---variáveis-no-sql)
- [3 - Condicionais IF com SQL](#3---condicionais-if-com-sql)
- [4 - Condicionais CASE com SQL](#4---condicionais-case-com-sql)
- [5 - TRIGGERS automatize seu banco de dados](#5---triggers-automatize-seu-banco-de-dados)
- [6 - BEFORE \& AFTER INSERT Triggers](#6---before--after-insert-triggers)
- [7 - BEFORE \& AFTER UPDATE Triggers](#7---before--after-update-triggers)
- [8 - BEFORE \& AFTER DELETE Triggers](#8---before--after-delete-triggers)
- [9 - Boas Práticas sobre uso de Triggers](#9---boas-práticas-sobre-uso-de-triggers)
- [10 - STORED PROCEDURE - Automatize queries comuns](#10---stored-procedure---automatize-queries-comuns)



## 1 - Como criar visualizações auto-atualizáveis com VIEW

```sql
USE company;

-- criar visualizacao de uma query recorrente
CREATE VIEW preco_medio_por_produto AS
SELECT productLine,
    AVG(buyPrice) AS average_price
FROM products
GROUP BY productLine;

-- usando a VIEW criada
SELECT *
FROM preco_medio_por_produto;

-- nao e possivel alterar a query, mas e possivel ordenar resultados
SELECT *
FROM preco_medio_por_produto
ORDER BY average_price;
```


## 2 - Variáveis no SQL

```sql
-- atribuindo valor a uma variavel
SET @pais = 'USA';
SELECT @pais;

-- atribuindo valor numerico
SET @numero = 10;
SELECT @numero;

-- organizando o codigo e melhorando a legibilidade do codigo
SET @product_code = 'S18_1749';

-- query que calcula o total de vendas daquele produto
SELECT productCode, SUM(quantityOrdered) AS TotalVendas
FROM orderdetails
WHERE productCode = @product_code
GROUP BY productCode;
```

**Quando usar**: 
- meu codigo esta ficando muito ilegivel? 
- meu codigo esta ficando grande demais, com muitos valores soltos dentro dele ?



## 3 - Condicionais IF com SQL

```sql
-- criando uma condional IF(<condicao>, 'verdadeiro', 'falso')
-- considerando: limite de credito alto >= 50k e baixo < 50k
SELECT customerNumber, customerName, creditLimit, 
IF (creditLimit >= 50000, 'Alto', 'Baixo') AS classificacao_credito
FROM customers;

-- considerando: retornar o 'officeCode', 'city', 'phone' e se o pais (country) 
-- for 'USA', atribuir 'local', se nao, atribuir 'externo'.
SELECT officeCode, city, phone, 
IF (country = 'USA', 'local', 'externo') AS regiao
FROM offices;

-- considerando: retornar o 'orderNumber', 'productCode' e 'tamanho_pedido' 
-- onde 'quantityOrdered' se for > 30, entao 'grande', se nao 'pequeno'
SELECT orderNumber, productCode, 
IF (quantityOrdered > 30, 'grande', 'pequeno') AS tamanho_pedido
FROM orderdetails;
```


## 4 - Condicionais CASE com SQL

```sql
-- considerando: retornar 'customerNumber', 'customerName' e 
-- 'Classificacao_credito' se limite > 70k, alto, se limite entre 50k e 70k, 
-- medio, se nao, baixo
SELECT customerNumber, customerName, 
CASE
    WHEN creditLimit > 70000 THEN 'alto'
    WHEN creditLimit BETWEEN 50000 AND 70000 THEN 'medio'
    ELSE 'baixo'
END AS classificacao_credito
FROM customers;

-- considerando: retornar o 'orderNumber', 'productCode', 'quantityOrdered' e 
-- tamanho_pedido de acordo com:
-- quantidade maior que 50, grande
-- quantidade entre 30 e 50, medio
-- caso contrario, pequena
SELECT orderNumber, productCode, quantityOrdered, 
CASE
    WHEN quantityOrdered > 50 THEN 'grande'
    WHEN quantityOrdered BETWEEN 30 AND 50 THEN 'medio'
    ELSE 'pequeno'
END AS tamanho_pedido
FROM orderdetails;


-- DESAFIO: 
-- considerando: a partir da tabela 'products', retorne o 'productCode', 
-- 'productName', 'buyPrice' e 'categoria' como:
-- buyPrice > 100, 'caro'
-- buyPrice entre 50 e 100, 'moderado'
-- caso contrario, 'barato'
SELECT productCode, productName, buyPrice,
CASE
    WHEN buyPrice > 100 THEN 'caro'
    WHEN buyPrice BETWEEN 50 AND 100 THEN 'moderado'
    ELSE 'barato'
END AS categoria
FROM products;
```

## 5 - TRIGGERS automatize seu banco de dados

- **BEFORE INSERT (antes de inserir)**: Acionado antes de uma nova linha ser 
  inserida em uma tabela.
- **AFTER INSERT (depois de inserir)**: Acionado depois de uma nova linha ser 
  inserida em uma tabela.
- **BEFORE UPDATE (antes de atualizar)**: Acionado antes de uma linha ser 
  atualizada em uma tabela.
- **AFTER UPDATE (depois de atualizar)**: Acionado depois de uma linha ser 
  atualizada em uma tabela.
- **BEFORE DELETE (antes de excluir)**: Acionado antes de uma linha ser 
  excluída em uma tabela.
- **AFTER DELETE (depois de excluir)**: Acionado depois de uma linha ser 
  excluída em uma tabela.


## 6 - BEFORE & AFTER INSERT Triggers

```sql
-- AFTER INSERT
-- situacao: queremos manter um registro dos novos clientes inseridos, 
-- portanto, vamos criar um gatilho que insira um registro na tabela 'auditoria'
-- sempre que um novo cliente for adicionado

-- criando a tabela auditoria para registro do trigger
CREATE TABLE auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customerNumber INT, 
    acao VARCHAR(150), 
    dataHora DATETIME
);

-- criando um trigger para registro a cada cliente novo inserido
-- DELIMITER $$ -- (utilizar no MySQL Workbench)
CREATE TRIGGER registrar_novo_cliente
AFTER INSERT ON customers
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (customerNumber, acao, dataHora)
    VALUES (NEW.customerNumber, 'cliente inserido', NOW());
END;
-- END; $$
-- DELIMITER ;

-- insere o registro de um cliente novo, para gerar um trigger after:
INSERT INTO company.customers (
    customerNumber,customerName,contactLastName,contactFirstName,phone,
    addressLine1,addressLine2,city,state,postalCode,country,
    salesRepEmployeeNumber,creditLimit
)
VALUES(
    498,'Loja de Esportexs','Doug','Jeff','33-99885-6895','Rua Roberto Campos',
    'casa 2','Porto Alegre','RS','335896','Brazil',1165,65000
);

-- verifica o registro do cliente inserido
SELECT *
FROM auditoria;


-- BEFORE INSERT
-- criar um trigger antes de insercoes que impeca que nomes duplicados sejam 
-- inseridos
-- DELIMITER $$ -- (utilizar no MySQL Workbench)
CREATE TRIGGER verificar_nome_duplicado
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM customers
    WHERE customerName = NEW.customerName;

    IF total > 0 THEN
        SIGNAL SQLSTATE '45000' -- cancela a operacao
            SET MESSAGE_TEXT = 'Ja existe um cliente com esse nome.';
    END IF;
END; 
-- DELIMITER ;

-- lista os triggers criados
SHOW TRIGGERS;

-- tenta inserir dados duplicados de clientes verificando com before:
INSERT INTO company.products (
    productCode, productName, productLine, productScale, productVendor, 
    productDescription, quantityInStock, buyPrice, MSRP)
VALUES (
    'S10_1809', '1969 Harley Davidson Ultimate Chopper', 'Motorcycles', '1:10', 
    'Min Lin Diecast', 'This replica features working kickstand, 
    front suspension, gear-shift lever, footbrake lever, drive chain, 
    wheels and steering. All parts are particularly delicate due to their 
    precise scale and require special care and attention.', 7933, 5, 95.70
);


-- AVISO:
-- nao crie triggers que resolvem um problema que poderia ter sido resolvido 
-- por uma restricao em uma coluna
```


## 7 - BEFORE & AFTER UPDATE Triggers

```sql
-- BEFORE UPDATE
-- situacao: queremos garantir o limite de credito dos clientes nao seja 
-- reduzido em mais de 10% em uma unica atualizacao
CREATE TRIGGER verifica_diminuicao_limite_credito
BEFORE UPDATE ON customers
FOR EACH ROW
BEGIN
    IF NEW.creditLimit < OLD.creditLimit * .9 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Não é permitido reduzir limite de crédito em mais de 10%';
    END IF;
END;

-- verifica se trigger foi criado
SHOW TRIGGERS;

-- teste
UPDATE customers
SET creditLimit = creditLimit * .8
WHERE customerNumber = 103;


-- DESAFIO:
-- crie um trigger que impeca a alteracao do preco de um produto para mais de
-- 50% do preco original
CREATE TRIGGER antes_update_preco
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    IF NEW.buyPrice > OLD.buyPrice * 1.5 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Não é permitido aumentar o preço em mais de 50%';
    END IF;
END; 

-- verificando se trigger foi criado
SHOW TRIGGERS;

-- teste
UPDATE products
SET buyPrice = buyPrice * 2
WHERE productCode = 'S10_2016';


-- AFTER UPDATE
-- situacao: queremos registrar quando o limite de credito de um cliente é 
-- aumentado na tabela de auditoria
CREATE TRIGGER registrar_aumento_limite_credito
AFTER UPDATE ON customers
FOR EACH ROW
BEGIN
    -- IF OLD.creditLimit < NEW.creditLimit THEN
    IF NEW.creditLimit > OLD.creditLimit THEN
        INSERT INTO auditoria (customerNumber, acao, dataHora)
        VALUES (
            NEW.customerNumber, CONCAT(
                'Limite de crédito aumentado de: ', 
                OLD.creditLimit, 
                ' para: ', 
                NEW.creditLimit
            ), NOW()
        );
    END IF;
END;

-- verificando se trigger foi criado
SHOW TRIGGERS 
WHERE `Trigger` = 'registrar_aumento_limite_credito';

-- teste
UPDATE customers
SET creditLimit = creditLimit * 1.1
WHERE customerNumber = 103;

-- verificando trigger resgistrado
SELECT *
FROM auditoria;


-- ** criando nova tabela auditoria para exemplos futuros **
CREATE TABLE TabelaAuditoria (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nomeTabela VARCHAR(64),
    acao VARCHAR(150),
    dataHora DATETIME,
    detalhes TEXT
);

DESCRIBE TabelaAuditoria;


-- DESAFIO: AFTER UPDATE trigger
-- crie um gatilho que registre cada alteracao de preco de produto na tabela 
-- de auditoria (TabelaAuditoria) com o seguinte formato:
-- "O preço do produto <código_produto> mudou de <preco_antigo> para 
-- <novo_preco>"
CREATE TRIGGER alteracao_preco_produto
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    IF NEW.buyPrice <> OLD.buyPrice THEN
        INSERT INTO TabelaAuditoria(nomeTabela, acao, dataHora, detalhes)
        VALUES(
            'products', 
            'update',
            NOW(),
            CONCAT(
                'O preço do produto ',
                NEW.productCode,
                ' mudou de ',
                OLD.buyPrice,
                ' para ',
                NEW.buyPrice,'.'
            )
        );
    END IF;
END;

-- verificando se trigger foi criado
SHOW TRIGGERS 
WHERE `Trigger` = 'alteracao_preco_produto';

-- teste
UPDATE products
SET buyPrice = buyPrice * .9
WHERE productCode = 'S10_2016';

-- verificar tabelaAuditoria
SELECT *
FROM tabelaauditoria;


-- AVISO:
-- nao crie triggers que resolvem um problema que poderia ter sido resolvido 
-- por uma restricao em uma coluna
```


## 8 - BEFORE & AFTER DELETE Triggers

```sql
-- BEFORE DELETE
-- situacao: queremos evitar a exclusao de um produto que ainda esta associado 
-- a um pedido na tabela 'orderdetails'
CREATE TRIGGER verificar_pedido_pendente
BEFORE DELETE ON products
FOR EACH ROW
BEGIN
    IF (
        SELECT COUNT(*)
        FROM orderdetails
        WHERE productCode = OLD.productCode
    ) > 0 THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não pode excluir um produto com pedidos pendentes.';
    END IF;
END;

-- verificando produto com pedido pendente
SELECT *
FROM orderdetails
WHERE productCode = 'S18_1749';

-- teste
DELETE FROM products
WHERE productCode = 'S18_1749';


-- AFTER DELETE
-- situacao: queremos manter um registro dos produtos que foram excluidos
CREATE TRIGGER registrar_produto_excluido
AFTER DELETE ON products
FOR EACH ROW
BEGIN
    INSERT INTO TabelaAuditoria (nomeTabela, acao, dataHora, detalhes)
    VALUES (
        'products',
        'Produto excluído',
        NOW(),
        CONCAT(
            'Product Code: ', OLD.productCode
        )
    );
END;

-- teste
DELETE FROM orderdetails
WHERE productCode = 'S18_1749';

DELETE FROM products
WHERE productCode = 'S18_1749';

-- registro na tabela de auditoria
SELECT *
FROM tabelaauditoria;


-- AVISO:
-- nao crie triggers que resolvem um problema que poderia ter sido resolvido 
-- por uma restricao em uma coluna
```


## 9 - Boas Práticas sobre uso de Triggers

- Não é sempre que é necessário criar uma tabela de auditoria. Essa prática pode 
  aumentar o consumo de espaço de armazenamento e por consequência aumentar os 
  custos com o banco de dados, e por fim, triggers podem tornar as operações de 
  dados mais lentas.
- Não crie triggers para resolver problemas que uma restrição de colunas poderia 
  resolver. 


## 10 - STORED PROCEDURE - Automatize queries comuns

```sql
-- Cria uma função reutilizável que faz uma operação em sua base de dados.
-- situacao: montar uma stored procedure que permita entrar com uma categoria 
-- de veiculo e retorne todos os registros que pertencem a aquela categoria
CREATE PROCEDURE ObterProdutoPorCategoria(
    IN product_line VARCHAR(50)
)
BEGIN
    SELECT *
    FROM products
    WHERE productLine = product_line;
END;

-- listando a procedure criada
SHOW PROCEDURE STATUS
WHERE Db = 'company';

-- chamando a procedure
CALL ObterProdutoPorCategoria('Classic Cars');

-- situacao: retornar produtos dentro de um faixa de preco minima e maxima
CREATE PROCEDURE BuscaProdutosPorPreco(
    IN preco_min DECIMAL(10,2), 
    IN preco_max DECIMAL(10,2)
)
BEGIN
    SELECT *
    FROM products
    WHERE buyPrice BETWEEN preco_min AND preco_max;
END;

-- chamando a procedure
CALL BuscaProdutosPorPreco(100, 500);


-- DIFERENCA DE USO DO TIPO 'IN' E TIPO 'OUT':
-- IN: tipo de parametro padrao e permite que passe valores para a stored 
-- procedure
-- OUT: esse parametro permite que a stored procedure retorne o valores
CREATE PROCEDURE PrecoMedioProduto(
    IN product_line VARCHAR(50),
    OUT preco_medio DECIMAL(10,2)
)
BEGIN
    SELECT AVG(buyPrice) INTO preco_medio
    FROM products
    WHERE productLine = product_line;
END;

SHOW PROCEDURE STATUS
WHERE Db = 'company';

-- chamando procedure e verificando valor retornado
CALL PrecoMedioProduto('Classic Cars', @precoMedio);
SELECT @precoMedio;


-- DESAFIO
-- criar uma stored procedure que retorna todos os clientes (customers) 
-- cadastrados em um determinado pais (country)
CREATE PROCEDURE ClientesDoPais(
    IN customer_country VARCHAR(50)
)
BEGIN
    SELECT customerName
    FROM customers
    WHERE country = customer_country;
END;

CALL ClientesDoPais('USA');


-- DESAFIO
-- criar um stored procedure que recebe um numero do cliente (customerNumber)
-- da tabela customer e retorna o seu limite de credito (creditLimit)
-- USANDO SOMENTE O IN:
CREATE PROCEDURE LimiteDeCreditoDoCliente(
    IN customer_number INT
)
BEGIN
    SELECT customerNumber, customerName, creditLimit
    FROM customers
    WHERE customerNumber = customer_number;
END;

CALL LimiteDeCreditoDoCliente(103);

-- USANDO OUT:
CREATE PROCEDURE LimiteDeCreditoDoClienteRetorno(
    IN customer_number INT,
    OUT credit_limit DECIMAL(10,2)
)
BEGIN
    SELECT creditLimit INTO credit_limit
    FROM customers
    WHERE customerNumber = customer_number;
END;

CALL LimiteDeCreditoDoClienteRetorno(103, @limiteCliente);
SELECT @limiteCliente;
```

-- mostrando todos os bancos da conexao
SHOW DATABASES;

-- mostrar tabelas do banco de dados
SHOW TABLES;

-- excluindo bancos da conexao
DROP DATABASE mod5_desafio;
DROP DATABASE mod5_desafios;
DROP DATABASE eventos;
DROP DATABASE mod5;



-- DESAFIO --

-- criar e usar um banco de dados
CREATE DATABASE IF NOT EXISTS mod5_db;
USE mod5_db;

-- criar uma tabela de eventos
CREATE TABLE eventos(
    evento_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    descricao VARCHAR(2000),
    data_evento DATE,
    localizacao VARCHAR(200),
    confirmado BOOLEAN DEFAULT 0
);

-- mostrar tabela especifica
SELECT * FROM eventos;

-- monstrando todas as colunas da tabela
SHOW COLUMNS FROM eventos;

-- modificar o comportamento de uma coluna da tabela
ALTER TABLE eventos
MODIFY COLUMN confirmado BOOLEAN DEFAULT 0;

-- inserindo valores na tabela
INSERT INTO eventos (titulo, descricao, data_evento, localizacao, confirmado)
VALUES
(
    'Conferência de Tecnologia', 
    'Um evento que aborda as últimas tendências tecnológicas',
    '2023-07-15',
    'Av. Paulista, 123, São Paulo, SP',
    1
),
(
    'Comemoração Clube MotoMais', 
    'Uma celebração para comemorar um aniversário do clube MotoMais',
    '2023-08-20',
    'Rua Copacabana, 456, Rio de Janeiro, RJ',
    1
);
SELECT * FROM eventos;

-- modificar o tamanho da descricao de 2000 para 2500
ALTER TABLE eventos
MODIFY COLUMN descricao VARCHAR(2500);
SHOW COLUMNS FROM eventos;

-- add coluna patrocinador, tipo texto 100 caracteres valor padrao 'a definir'
ALTER TABLE eventos
ADD COLUMN patrocinador  VARCHAR(100) DEFAULT 'a definir';
SHOW COLUMNS FROM eventos;

-- rm coluna patrocinador
ALTER TABLE eventos
DROP COLUMN patrocinador;
SHOW COLUMNS FROM eventos;
-- criar novo banco de dados
CREATE DATABASE IF NOT EXISTS my_db;

-- alternar para o uso do novo banco de dados
USE my_db;

-- criar nova tabela no banco de dados
CREATE TABLE pessoa(
	pessoa_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    sobrenome VARCHAR (80),
    idade INTEGER NOT NULL,
    ativo BOOLEAN DEFAULT 1,
    altura FLOAT,
    data_nascimento DATE
);

-- mostrar tabelas
SHOW tables;

-- listar todas as colunas da tabela
SHOW COLUMNS FROM cursos;

-- inserir dados 
INSERT INTO pessoa (nome, sobrenome, idade, ativo, altura, data_nascimento)
VALUES ('Alan', 'Vasconcelos', 32, 1, 1.75, '1990-04-23');

-- inserir varios dados ao mesmo tempo
INSERT INTO pessoa (nome, sobrenome, idade, ativo, altura, data_nascimento)
VALUES 
('Mariana', 'Sousa', 45, 1, 1.60, '1980-09-15'),
('Carla', 'Oliveira', 25, 1, 1.55, '1999-01-28'),
('Rafael', 'Santos', 52, 1, 1.73, '1972-07-05');

-- alterar a restriçao de uma coluna
ALTER TABLE pessoa
MODIFY COLUMN ativo BOOLEAN DEFAULT 0;

-- alterar a restriçao de mais de uma coluna
ALTER TABLE pessoa
MODIFY COLUMN nome VARCHAR(50) NOT NULL,
MODIFY COLUMN sobrenome VARCHAR(50);

-- adicionar nova coluna
ALTER TABLE pessoa
ADD COLUMN nota FLOAT NULL;

-- remover coluna
ALTER TABLE pessoa
DROP COLUMN nota;


-- atualizar dados
UPDATE pessoa
SET ativo = 0
WHERE nome = 'Carla';


-- esvaziar uma tabela mantendo a estrutura da tabela
TRUNCATE pessoa;


-- deletar uma tabela
DROP TABLE pessoa;

-- visualizar dados inseridos
SELECT *
FROM pessoa;

-- listar todas as colunas da tabela
SHOW COLUMNS FROM pessoa;
DESCRIBE pessoa;



-- criar nova tabela gerenciamento dos cursos
CREATE TABLE cursos(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    curso VARCHAR(40) NOT NULL,
    modulos INTEGER NOT NULL,
    aulas INTEGER NOT NULL,
    progresso DECIMAL(3,2),
    faltam_certificacao DECIMAL(3,2)
);

DESCRIBE cursos;

-- inserindo dados na tabela
INSERT INTO cursos (curso, modulos, aulas, progresso, faltam_certificacao)
VALUES 
    ('pythonista autodidata', 15, 206, 0.58, 0.17),
    ('mestres da automacao', 14, 247, 0.36, 0.39),
    ('sql direto ao ponto', 8, 62, 0.40, 0.35),
    ('analista de dados pro', 6, 57, 0.02, 0.73),
    ('mestre freelancer', 1, 21, 0.43, NULL),
    ('metodo acelerador de carreira dev', 1, 7, 0.14, NULL),
    ('metodo dev lucrativo', 1, 6, 0.17, NULL);

-- visualizando dados
SELECT *
FROM cursos;

-- criando tabela conhecimentos
CREATE TABLE conhecimentos(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    conhecimento VARCHAR(40) NOT NULL,
    modulos INTEGER NOT NULL,
    aulas INTEGER NOT NULL,
    concluido DECIMAL(3,2)
);

-- mostrando tabelas criadas no database
SHOW tables;

-- mostrando tabela recem criada
DESCRIBE conhecimentos;

-- modificando restricoes de dados
ALTER TABLE conhecimentos
MODIFY COLUMN modulos INTEGER,
MODIFY COLUMN aulas INTEGER;

-- inserindo dados
INSERT INTO conhecimentos (conhecimento, modulos, aulas, concluido)
VALUES
    ('ling. de programacao', 35, 510, 0.32),
    ('bando de dados', 8, 62, 0.40),
    ('container', NULL, NULL, NULL),
    ('cloud', NULL, NULL, NULL);

-- visualizando dados
SELECT *
FROM conhecimentos;

CREATE TABLE storage(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    app VARCHAR(50) NOT NULL,
    user VARCHAR(50) NOT NULL,
    hash VARCHAR(64) NOT NULL
);

DESCRIBE storage;
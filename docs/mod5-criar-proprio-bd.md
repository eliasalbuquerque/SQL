<!--
title: 'mod5-criar-proprio-bd.md'
author: 'Elias Albuquerque'
created: '2024-02-18'
update: '2024-02-18'
-->


# Módulo 5 - Como criar seu Próprio Banco de Dados e Tabelas


- [1 - Como criar um banco de dados e utilizá-lo no VSCode](#1---como-criar-um-banco-de-dados-e-utilizá-lo-no-vscode)
- [2 - Preencha suas tabelas com o "Insert into"](#2---preencha-suas-tabelas-com-o-insert-into)
- [3 - Modifique a estrutura de uma tabela utilizando o "Alter table"](#3---modifique-a-estrutura-de-uma-tabela-utilizando-o-alter-table)
- [4 - Atualize dados com o "Update"](#4---atualize-dados-com-o-update)
- [5 - Esvazie tabelas através do "Truncate table"](#5---esvazie-tabelas-através-do-truncate-table)
- [6 - Aprenda excluir tabelas com o "Drop table"](#6---aprenda-excluir-tabelas-com-o-drop-table)
- [7 - Desafio e Projeto - gestão de Eventos - Criação](#7---desafio-e-projeto---gestão-de-eventos---criação)
- [8 - Projeto - Gestão de Eventos - Inserção de dados](#8---projeto---gestão-de-eventos---inserção-de-dados)
- [9 - Projeto - Gestão de Eventos - Revisões finais](#9---projeto---gestão-de-eventos---revisões-finais)



## 1 - Como criar um banco de dados e utilizá-lo no VSCode

Para criar um novo banco de dados **localmente** usando o **PowerShell**, você 
pode seguir estas etapas:

1. **Abra o PowerShell**:
    - Abra o PowerShell no seu sistema operacional (Windows).

2. **Conecte-se ao MySQL**:
    - Digite o seguinte comando para fazer login no MySQL (substitua `<usuário>` 
      e `<senha>` pelos seus detalhes de acesso):
        ```powershell
        mysql -u <usuário> -p
        ```
    - Pressione Enter e digite sua senha quando solicitado.

3. **Crie um novo banco de dados**:
    - No prompt do MySQL, execute o seguinte comando para criar um novo banco de 
      dados (substitua `<nome_do_banco>` pelo nome desejado):
        ```sql
        CREATE DATABASE <nome_do_banco>;
        ```

Caso o PowerShell não esteja reconhecendo o comando `mysql`:

1. **Verifique se o PATH contém o executável do MySQL**:
   ```powershell
   $env:Path
   ```
  
2. **Adicione o MySQL ao PATH**:
   ```powershell
   $env:Path += ";C:\Program Files\MySQL\MySQL Server 8.0\bin"
   ```

3. **Persistência do PATH**:
   ```powershell
   setx PATH "$env:Path;C:\Program Files\MySQL\MySQL Server 8.0\bin"
   ```

Agora, crie uma nova conexão no VSCode usando a extensão SQLTools:

1. **Configure a Conexão**:
   - Clique no ícone “SQLTools” na barra inferior do VSCode.
   - Clique no botão “+” para adicionar uma nova conexão. 
   
   Ou:
   
   - Pressione Ctrl + Shift + P para abrir a Paleta de Comandos.
   - Digite “sql” para exibir os comandos relacionados ao SQLTools.
   - Selecione “MS SQL: Connect” na lista suspensa.
   - Siga as instruções para criar um novo perfil de conexão:

2. **Preencha os detalhes da conexão**:
     - Nome da conexão: Escolha um nome para a conexão (por exemplo, 
       “Meu MySQL”).
     - Host: Normalmente, é “localhost” se o servidor MySQL estiver na mesma 
       máquina.
     - Porta: A porta padrão do MySQL é 3306.
     - Usuário: Seu nome de usuário do MySQL.
     - Senha: Sua senha do MySQL.
     - Banco de Dados: O nome do banco recém criado.
     - Salve a conexão.

Agora é só iniciar a conexão que abrirá um arquivo .sql para inserir as queries.


## 2 - Preencha suas tabelas com o "Insert into"

```sql
-- inserir dados 
INSERT INTO pessoa (nome, sobrenome, idade, ativo, altura, data_nascimento)
VALUES ('Alan', 'Vasconcelos', 32, 1, 1.75, '1990-04-23');

-- inserir varios dados ao mesmo tempo
INSERT INTO pessoa (nome, sobrenome, idade, ativo, altura, data_nascimento)
VALUES 
('Mariana', 'Sousa', 45, 1, 1.60, '1980-09-15'),
('Carla', 'Oliveira', 25, 1, 1.55, '1999-01-28'),
('Rafael', 'Santos', 52, 1, 1.73, '1972-07-05');
```


## 3 - Modifique a estrutura de uma tabela utilizando o "Alter table"

```sql
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
```


## 4 - Atualize dados com o "Update"

```sql
-- atualizar dados
UPDATE pessoa
SET ativo = 0
WHERE nome = 'Carla';
```


## 5 - Esvazie tabelas através do "Truncate table"

```sql
-- esvaziar uma tabela mantendo a estrutura da tabela
TRUNCATE pessoa;
```


## 6 - Aprenda excluir tabelas com o "Drop table"

```sql
-- deletar uma tabela
DROP TABLE pessoa;
```


## 7 - Desafio e Projeto - gestão de Eventos - Criação

```sql
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
```


## 8 - Projeto - Gestão de Eventos - Inserção de dados

```sql
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
```


## 9 - Projeto - Gestão de Eventos - Revisões finais

```sql
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
```

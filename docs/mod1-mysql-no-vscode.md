<!--
title: 'mod1-mysql-no-vscode.md'
author: 'Elias Albuquerque'
created: '2024-02-18'
update: '2024-03-14'
-->

# MySQL No VSCode

Este documento é um recurso que cobre tudo, desde a instalação do MySQL até a 
criação e manipulação de bancos de dados. Ele foi criado com o objetivo de 
fornecer um caminho claro e estruturado para aplicar os conceitos do MySQL, com 
ênfase especial na integração com o VSCode.

- [Instalação do MySQL](#instalação-do-mysql)
- [Criando um Banco de Dados Localmente](#criando-um-banco-de-dados-localmente)
- [Conexão Com o Banco de Dados com a Extensão SQLTools](#conexão-com-o-banco-de-dados-com-a-extensão-sqltools)


## Instalação do MySQL

Antes de começar a criar um novo banco de dados, você precisa ter o MySQL 
instalado em sua máquina. Aqui estão as etapas para instalar o MySQL:

1. **Baixe o instalador do MySQL**:
   - Acesse o site oficial do MySQL (https://dev.mysql.com/downloads/installer/).
   - Baixe o instalador do MySQL Community Server.

2. **Instale o MySQL**:
   - Execute o instalador que você baixou.
   - Siga as instruções na tela para instalar o MySQL.

Agora que o MySQL está instalado, você pode criar um novo banco de dados 
localmente usando o terminal do VSCode.


## Criando um Banco de Dados Localmente

Para criar um novo banco de dados localmente usando o VSCode, você pode seguir 
estas etapas:

1. **Abra o Terminal PowerShell**:
   - `Ctrl+J` para abrir o terminal.

2. **Conecte-se ao MySQL**:
   - Digite o seguinte comando para fazer login no MySQL (substitua `<usuário>` e `<senha>` pelos seus detalhes de acesso):
     ```powershell
     mysql -u <usuário> -p
     ```
   - Pressione Enter e digite sua senha quando solicitado.

3. **Crie um novo banco de dados**:
   - No prompt do MySQL, execute o seguinte comando para criar um novo banco de dados (substitua `<nome_do_banco>` pelo nome desejado):
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

## Conexão Com o Banco de Dados com a Extensão SQLTools

Após instalação do MySQL e criado o banco de dados, crie uma nova conexão no 
VSCode usando a extensão SQLTools:

1. **Configure a Conexão**:
   - Clique no ícone “SQLTools” na barra inferior do VSCode.
   - Clique no botão “+” para adicionar uma nova conexão. 
   
   Ou:
   
   - Pressione Ctrl + Shift + P para abrir a Paleta de Comandos.
   - Digite “sql” para exibir os comandos relacionados ao SQLTools.
   - Selecione “MS SQL: Connect” na lista suspensa.
   - Siga as instruções para criar um novo perfil de conexão:

2. **Preencha os detalhes da conexão**:
   - Nome da conexão: Escolha um nome para a conexão (por exemplo, “Meu MySQL”).
   - Host: Normalmente, é “localhost” se o servidor MySQL estiver na mesma máquina.
   - Porta: A porta padrão do MySQL é 3306.
   - Usuário: Seu nome de usuário do MySQL.
   - Senha: Sua senha do MySQL.
   - Banco de Dados: O nome do banco recém criado.
   - Salve a conexão.

Agora é só iniciar a conexão que abrirá um arquivo .sql para inserir as queries.


# Projeto Prático - Análise do Banco de Dados MediaWiki

## 1. Apresentação

Este projeto foi desenvolvido para a disciplina de Banco de Dados do curso de Engenharia de Software.

O objetivo é analisar a estrutura de um banco de dados real, utilizando a plataforma MediaWiki e o sistema gerenciador MySQL 8.

Durante o desenvolvimento, realizamos a instalação da plataforma, analisamos tabelas e relacionamentos, importamos dados fictícios, executamos consultas SQL, criamos visões e testamos uma proposta de melhoria na integridade dos dados.

## 2. Tecnologias utilizadas

- MediaWiki 1.43
- MySQL 8
- Docker e Docker Compose
- Visual Studio Code
- Python
- SQL
- Mermaid para o diagrama ER

## 3. Como executar o projeto

O ambiente foi configurado utilizando Docker Compose,
MediaWiki 1.43 e MySQL 8.

### 3.1. Iniciar os containers

Abra a pasta projeto-mediawiki no VS Code.

No terminal, execute:

docker compose up -d

### 3.2. Verificar os containers

Execute:

docker compose ps

Os serviços database e mediawiki devem aparecer
com o status Up.

### 3.3. Acessar o MediaWiki

Com os containers funcionando, abra o navegador
e acesse:

http://localhost:8080

A plataforma deverá apresentar a página principal
da Wiki Engenharia de Software.

### 3.4. Configuração inicial

Na primeira instalação, é necessário configurar
o MediaWiki e gerar o arquivo LocalSettings.php.

Esse arquivo deve ficar na pasta principal
projeto-mediawiki, conforme a configuração
do Docker Compose.

Após configurar o arquivo, execute novamente:

docker compose up -d

## 4. Carga de dados fictícios

Para realizar os testes, foram utilizados dados fictícios,
sem informações pessoais reais.

A geração e a importação dos dados foram organizadas
nos seguintes arquivos:

- gerar_dados.py: script Python para geração dos dados.
- importar_dados.cmd: script de importação no MediaWiki.
- dados_ficticios/: pasta que contém os seis lotes de dados.

### 4.1. Importar os dados

Com os containers Docker em execução, abra o terminal
na pasta principal do projeto e execute:

```powershell
.\importar_dados.cmd
```

O script importa os artigos fictícios para o MediaWiki.

### 4.2. Resultado da importação

Foram importados 240 artigos fictícios, organizados
em seis lotes de 40 artigos.

Após a importação, o banco apresentou:

- 241 páginas, incluindo a página principal.
- 241 revisões.
- 241 registros de conteúdo.
- 241 registros na tabela slots.
- 8 autores registrados na tabela actor.

### 4.3. Verificação dos dados

Para conferir a quantidade de páginas, utilizamos:

```sql
SELECT COUNT(*) AS total_paginas FROM page;
```

Resultado obtido:

total_paginas = 241

Esse resultado confirmou que os artigos fictícios
foram importados e armazenados no banco de dados.

## 5. Consultas SQL e visões

Após a importação dos dados fictícios, realizamos
cinco consultas SQL para analisar informações
armazenadas no banco do MediaWiki.

### 5.1. Consultas SQL

As consultas estão disponíveis no arquivo:

sql/01_consultas.sql

Foram desenvolvidas as seguintes consultas:

1. Listagem de páginas e seus autores, utilizando JOIN.
2. Quantidade de revisões realizadas por autor,
   utilizando GROUP BY e COUNT.
3. Identificação dos dez maiores conteúdos,
   utilizando JOIN, ORDER BY e LIMIT.
4. Identificação dos conteúdos acima da média,
   utilizando uma subconsulta com AVG.
5. Verificação de revisões sem páginas e de
   slots sem conteúdos, utilizando LEFT JOIN.

Os resultados permitiram conhecer melhor a
organização dos dados e verificar a consistência
dos relacionamentos analisados.

### 5.2. Visões (VIEWs)

Criamos duas visões para facilitar a consulta
de informações do banco de dados.

Os comandos estão no arquivo:

sql/02_views.sql

As visões desenvolvidas foram:

- vw_paginas_autores: apresenta os identificadores,
  os títulos das páginas e seus autores.

- vw_revisoes_por_autor: apresenta os autores e
  a quantidade de revisões realizadas por cada um.

As duas visões foram criadas e consultadas
com sucesso no MySQL 8.

### 5.3. Resultados obtidos

Na análise dos dados importados, verificamos
que os seis editores fictícios realizaram
40 revisões cada um.

Também identificamos que não existiam revisões
sem páginas correspondentes nem slots sem
conteúdos correspondentes nos registros analisados.

Os códigos SQL utilizados estão disponíveis
na pasta sql do projeto.


## 6. Proposta de melhoria DDL

Durante a análise do banco de dados do MediaWiki,
observamos que os relacionamentos entre as tabelas
não possuem chaves estrangeiras declaradas.

Para demonstrar uma possível melhoria, criamos
um banco separado chamado mediawiki_teste_ddl.

A proposta foi implementar uma chave estrangeira
entre duas tabelas de teste:

- pagina_teste: armazena as páginas.
- revisao_teste: armazena as revisões das páginas.

### 6.1. Implementação

Utilizamos o comando ALTER TABLE para adicionar
uma restrição FOREIGN KEY ao campo rev_page,
referenciando o campo page_id da tabela pagina_teste.

O código utilizado está disponível em:

sql/03_melhoria_ddl.sql

### 6.2. Testes realizados

Realizamos três testes para verificar as restrições:

1. Inserção de uma revisão vinculada a uma página
   existente: operação realizada com sucesso.

2. Tentativa de cadastrar uma revisão com chave
   primária duplicada: erro 1062, conforme esperado.

3. Tentativa de cadastrar uma revisão vinculada a
   uma página inexistente: erro 1452, conforme esperado.

O erro 1452 demonstrou que a chave estrangeira
impediu o cadastro de uma referência inválida.

### 6.3. Vantagens e limitações

A principal vantagem da chave estrangeira é
proteger a integridade referencial dos dados.

Ela impede que uma revisão seja cadastrada
com referência a uma página inexistente.

Como limitação, a restrição exige cuidados
nas operações de inserção, exclusão e atualização,
além de poder adicionar custo de processamento.

No MediaWiki real, alterações desse tipo precisam
considerar a arquitetura da aplicação e sua
compatibilidade com futuras atualizações.

Por esse motivo, os testes foram realizados
em tabelas separadas, preservando o banco original.


## 7. Reproducao do ambiente

Para reproduzir o projeto em outro computador,
e necessario ter Docker Desktop e Git instalados.

### 7.1. Preparar a configuracao

Na pasta do projeto, execute no PowerShell:

```powershell
Copy-Item compose.example.yaml compose.yaml
Copy-Item .env.example .env
```

Abra o arquivo .env e substitua os valores
de exemplo por senhas fortes de sua escolha.

Nao publique o arquivo .env.

### 7.2. Iniciar o ambiente

Execute:

```powershell
docker compose up -d
```

Para verificar os containers:

```powershell
docker compose ps
```

### 7.3. Instalar o MediaWiki

Acesse:

http://localhost:8080

Na configuracao inicial, utilize:

- Servidor do banco: database
- Banco de dados: mediawiki
- Usuario do banco: wikiuser
- Senha: a definida em MYSQL_PASSWORD no .env

Conclua a instalacao e baixe LocalSettings.php.

Coloque LocalSettings.php na pasta principal
do projeto.

No arquivo compose.yaml, dentro de
services > mediawiki > volumes, acrescente:

```yaml
      - ./LocalSettings.php:/var/www/html/LocalSettings.php:ro
```

Depois execute novamente:

```powershell
docker compose up -d
```

### 7.4. Importar os dados

Com o MediaWiki configurado, siga as instrucoes
do arquivo LEIA-ME_CARGA.md e utilize
importar_dados.cmd para realizar a carga ficticia.

### 7.5. Consultas e melhoria DDL

Os scripts estao disponiveis na pasta sql:

- 01_consultas.sql
- 02_views.sql
- 03_melhoria_ddl.sql

As consultas e visoes utilizam o banco mediawiki.

A melhoria DDL utiliza um banco de testes
separado, chamado mediawiki_teste_ddl.

Os testes de insercao ja realizados estao
documentados no projeto.


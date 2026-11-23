
-- PROJETO MEDIAWIKI - MELHORIA DDL
-- Demonstracao de integridade referencial
-- Ambiente de teste separado do MediaWiki

-- 1. Criar banco para os testes
CREATE DATABASE IF NOT EXISTS mediawiki_teste_ddl;

USE mediawiki_teste_ddl;

-- 2. Criar tabela de paginas
CREATE TABLE pagina_teste (
    page_id INT UNSIGNED PRIMARY KEY,
    page_title VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

-- 3. Criar tabela de revisoes
CREATE TABLE revisao_teste (
    rev_id BIGINT UNSIGNED PRIMARY KEY,
    rev_page INT UNSIGNED NOT NULL
) ENGINE=InnoDB;

-- 4. Adicionar chave estrangeira
ALTER TABLE revisao_teste
ADD CONSTRAINT fk_revisao_pagina_teste
FOREIGN KEY (rev_page)
REFERENCES pagina_teste(page_id);

-- TESTES DA MELHORIA DDL

-- Teste 1: Insercao de pagina valida
INSERT INTO pagina_teste (page_id, page_title)
VALUES (1, 'Introducao ao Banco de Dados');

-- Teste 2: Revisao valida
INSERT INTO revisao_teste (rev_id, rev_page)
VALUES (1, 1);

-- Teste 3: Chave primaria duplicada
-- Esperado: ERROR 1062
-- INSERT INTO revisao_teste (rev_id, rev_page)
-- VALUES (1, 1);

-- Teste 4: Pagina inexistente
-- Esperado: ERROR 1452
-- INSERT INTO revisao_teste (rev_id, rev_page)
-- VALUES (2, 999);

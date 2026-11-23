
-- PROJETO MEDIAWIKI - MYSQL 8
-- Duas VIEWs do trabalho

-- VIEW 1: Paginas e autores
CREATE OR REPLACE VIEW vw_paginas_autores AS
SELECT
    p.page_id,
    CONVERT(p.page_title USING utf8mb4) AS titulo,
    CONVERT(a.actor_name USING utf8mb4) AS autor
FROM page p
JOIN revision r ON r.rev_id = p.page_latest
JOIN actor a ON a.actor_id = r.rev_actor;

-- VIEW 2: Quantidade de revisoes por autor
CREATE OR REPLACE VIEW vw_revisoes_por_autor AS
SELECT
    a.actor_id,
    CONVERT(a.actor_name USING utf8mb4) AS autor,
    COUNT(r.rev_id) AS total_revisoes
FROM actor a
LEFT JOIN revision r ON r.rev_actor = a.actor_id
GROUP BY a.actor_id, a.actor_name;

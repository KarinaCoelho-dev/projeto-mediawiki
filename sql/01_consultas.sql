
-- PROJETO MEDIAWIKI - MYSQL 8
-- Consultas SQL do trabalho

-- CONSULTA 1: Paginas e autores
SELECT p.page_id,
       CONVERT(p.page_title USING utf8mb4) AS titulo,
       CONVERT(a.actor_name USING utf8mb4) AS autor
FROM page p
JOIN revision r ON r.rev_id = p.page_latest
JOIN actor a ON a.actor_id = r.rev_actor
ORDER BY p.page_id
LIMIT 10;

-- CONSULTA 2: Revisoes por autor
SELECT CONVERT(a.actor_name USING utf8mb4) AS autor,
       COUNT(*) AS total_revisoes
FROM revision r
JOIN actor a ON r.rev_actor = a.actor_id
GROUP BY a.actor_id, a.actor_name
HAVING COUNT(*) >= 1
ORDER BY total_revisoes DESC;

-- CONSULTA 3: Dez maiores conteudos
SELECT p.page_id,
       CONVERT(p.page_title USING utf8mb4) AS titulo,
       c.content_size AS tamanho_bytes
FROM page p
JOIN revision r ON r.rev_id = p.page_latest
JOIN slots s ON s.slot_revision_id = r.rev_id
JOIN content c ON c.content_id = s.slot_content_id
ORDER BY c.content_size DESC
LIMIT 10;

-- CONSULTA 4: Conteudos acima da media
SELECT CONVERT(p.page_title USING utf8mb4) AS titulo,
       c.content_size AS tamanho_bytes
FROM page p
JOIN revision r ON r.rev_id = p.page_latest
JOIN slots s ON s.slot_revision_id = r.rev_id
JOIN content c ON c.content_id = s.slot_content_id
WHERE c.content_size >
      (SELECT AVG(content_size) FROM content)
ORDER BY c.content_size DESC
LIMIT 10;

-- CONSULTA 5: Verificacao de registros orfaos
SELECT
    (SELECT COUNT(*)
     FROM revision r
     LEFT JOIN page p ON r.rev_page = p.page_id
     WHERE p.page_id IS NULL) AS revisoes_sem_pagina,
    (SELECT COUNT(*)
     FROM slots s
     LEFT JOIN content c ON s.slot_content_id = c.content_id
     WHERE c.content_id IS NULL) AS slots_sem_conteudo;


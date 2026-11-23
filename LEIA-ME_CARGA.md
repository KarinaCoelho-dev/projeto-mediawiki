# Carga de dados ficticios - MediaWiki / MySQL 8

Pacote para a atividade academica. Usa o MediaWiki 1.43 ja instalado com Docker Compose.
Os 240 arquivos de texto e 6 editores ficticios sao inteiramente sinteticos.

## Uso no Windows, sem instalar Python

1. Extraia o conteudo deste ZIP diretamente **dentro** da sua pasta `projeto-mediawiki`,
   no mesmo nivel de `compose.yaml` e `LocalSettings.php`.
2. Confirme que o Docker Desktop esta em funcionamento e que sua wiki abre em
   `http://localhost:8080`.
3. Execute o arquivo `importar_dados.cmd` por duplo clique.
4. O script verifica o Compose, copia os arquivos ao container, importa 6 lotes de 40
   paginas e executa `refreshLinks` para atualizar os links e as categorias.
5. Confira no MySQL as contagens depois da carga:

   SELECT COUNT(*) AS paginas FROM page;
   SELECT COUNT(*) AS revisoes FROM revision;
   SELECT COUNT(*) AS usuarios FROM user;
   SELECT COUNT(*) AS categorias_vinculadas FROM categorylinks;

A importacao **nao sobrescreve** paginas existentes por padrao. Se uma execucao for
interrompida, preserve os volumes e verifique o erro antes de repetir.

## Reproducibilidade

`importar_dados.cmd` e o script de carga; os dados sinteticos em `dados_ficticios/`
estao inclusos e podem ser versionados. `gerar_dados.py` e um gerador opcional, que
recria os mesmos 240 arquivos usando somente a biblioteca padrao do Python, caso a
equipe instale Python em outro computador. Nao e necessario instalar Python agora.

Documentacao oficial:
- https://www.mediawiki.org/wiki/Manual:ImportTextFiles.php
- https://www.mediawiki.org/wiki/Manual:Run.php
- https://www.mediawiki.org/wiki/Manual:RefreshLinks.php

SEGURANCA: Nunca publique `LocalSettings.php` nem senhas de banco no GitHub.
Nao execute `docker compose down -v`, pois remove os volumes do banco.

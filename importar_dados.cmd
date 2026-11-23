@echo off
setlocal
cd /d "%~dp0"
echo === Importacao de dados ficticios para MediaWiki ===
if not exist "compose.yaml" (
  echo ERRO: compose.yaml nao encontrado. Extraia este pacote dentro de projeto-mediawiki.
  pause
  exit /b 1
)
if not exist "dados_ficticios\lote01\Artigo_001.txt" (
  echo ERRO: arquivos de dados ficticios nao encontrados.
  pause
  exit /b 1
)
echo Conferindo se o Docker reconhece o projeto...
docker compose config --quiet
if errorlevel 1 goto falha
echo Copiando os arquivos ficticios para o container do MediaWiki...
docker compose cp ".\dados_ficticios" "mediawiki:/tmp/"
if errorlevel 1 goto falha
echo Importando lote 1/6 como EditorFicticio01...
docker compose exec -T mediawiki php maintenance/run.php importTextFiles --prefix "Projeto/" --user "EditorFicticio01" --summary "Carga academica ficticia" --rc "/tmp/dados_ficticios/lote01/*.txt"
if errorlevel 1 goto falha
echo Importando lote 2/6 como EditorFicticio02...
docker compose exec -T mediawiki php maintenance/run.php importTextFiles --prefix "Projeto/" --user "EditorFicticio02" --summary "Carga academica ficticia" --rc "/tmp/dados_ficticios/lote02/*.txt"
if errorlevel 1 goto falha
echo Importando lote 3/6 como EditorFicticio03...
docker compose exec -T mediawiki php maintenance/run.php importTextFiles --prefix "Projeto/" --user "EditorFicticio03" --summary "Carga academica ficticia" --rc "/tmp/dados_ficticios/lote03/*.txt"
if errorlevel 1 goto falha
echo Importando lote 4/6 como EditorFicticio04...
docker compose exec -T mediawiki php maintenance/run.php importTextFiles --prefix "Projeto/" --user "EditorFicticio04" --summary "Carga academica ficticia" --rc "/tmp/dados_ficticios/lote04/*.txt"
if errorlevel 1 goto falha
echo Importando lote 5/6 como EditorFicticio05...
docker compose exec -T mediawiki php maintenance/run.php importTextFiles --prefix "Projeto/" --user "EditorFicticio05" --summary "Carga academica ficticia" --rc "/tmp/dados_ficticios/lote05/*.txt"
if errorlevel 1 goto falha
echo Importando lote 6/6 como EditorFicticio06...
docker compose exec -T mediawiki php maintenance/run.php importTextFiles --prefix "Projeto/" --user "EditorFicticio06" --summary "Carga academica ficticia" --rc "/tmp/dados_ficticios/lote06/*.txt"
if errorlevel 1 goto falha
echo Atualizando os indices de links e categorias...
docker compose exec -T mediawiki php maintenance/run.php refreshLinks
if errorlevel 1 goto falha
echo.
echo CONCLUIDO: importacao executada. Confira as contagens no MySQL.
echo As paginas existentes nao sao sobrescritas.
pause
exit /b 0
:falha
echo.
echo ERRO: a operacao foi interrompida. Nao apague volumes.
echo Envie a mensagem de erro para verificar antes de repetir o processo.
pause
exit /b 1

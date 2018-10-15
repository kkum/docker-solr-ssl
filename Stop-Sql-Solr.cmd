@echo off
echo [1/2] Stopping Solr and SQL containers ... 
docker-compose --file "%~dp0\docker-compose.yml" down

echo [2/2] Removing system environment variable DOCKER_SQL_SOLR
reg delete HKEY_CURRENT_USER\Environment /v DOCKER_SQL_SOLR /f
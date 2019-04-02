@echo off

echo [1a/3] Checking if certificate exists
IF NOT EXIST %~dp0certs\solr-ssl.keystore.pfx (
    echo [1b/3] Generating certificate
    powershell.exe -ExecutionPolicy Bypass -Command "%~dp0\Generate-Certificate.ps1"
) ELSE (
    echo [1b/3] Using existing %~dp0certs\solr-ssl.keystore.pfx
)
echo [2a/3] Starting Solr and SQL containers detached... 
docker-compose --file "%~dp0\docker-compose.yml" up --build --detach
echo [2b/3] Ensure Database is using Contained Authentication...  
timeout /t 20 /nobreak > NUL
docker-compose  --file "%~dp0\docker-compose.yml" exec mssql-2017 bash -c "/opt/mssql-tools/bin/sqlcmd -S. -Usa -PQwerty123 -i /var/opt/usecontaineddbauth.sql"

echo [3/3] Setting system environment variable DOCKER_SQL_SOLR

set DOCKER_SQL_SOLR=UP 
setx DOCKER_SQL_SOLR "UP" 

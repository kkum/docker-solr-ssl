@echo off
echo [1/3] Checking if certificate exists
IF NOT EXIST %~dp0certs\solr-ssl.keystore.pfx (
    echo [1/3] Generating certificate
    powershell.exe -ExecutionPolicy Bypass -Command "%~dp0\Generate-Certificate.ps1"
) ELSE (
    echo [1/3] Using existing %~dp0certs\solr-ssl.keystore.pfx
)
echo [2/3] Starting Solr and SQL containers detached... 
docker-compose --file "%~dp0\docker-compose.yml" up --detach --build

echo [3/3] Setting system environment variable DOCKER_SQL_SOLR

set DOCKER_SQL_SOLR=UP 
setx DOCKER_SQL_SOLR "UP" 
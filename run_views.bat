@echo off
CALL env.bat
if not exist "%~dp0views" mkdir "%~dp0views"

set "PGPASSWORD=%DB_PASSWORD%"

REM Executes each view script individually
echo Criando view_collections...
psql -q -U %DB_USER% -d %DB_DATABASE% -h %DB_HOST% -p %DB_PORT% -f scripts/views/view_collections.sql >> log.txt 2>&1

echo Criando view_cards...
psql -q -U %DB_USER% -d %DB_DATABASE% -h %DB_HOST% -p %DB_PORT% -f scripts/views/view_cards.sql >> log.txt 2>&1

echo Criando view_pokemon_attacks...
psql -q -U %DB_USER% -d %DB_DATABASE% -h %DB_HOST% -p %DB_PORT% -f scripts/views/view_pokemon_attacks.sql >> log.txt 2>&1

echo Todas as views foram criadas com sucesso!
pause

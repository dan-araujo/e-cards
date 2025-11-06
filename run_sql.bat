@echo off
CALL env.bat
setlocal
cd /d "%~dp0"

set "PGPASSWORD=%DB_PASSWORD%"
set "SCRIPT_PATH%=scripts\seeds\to_migration.ps1"

:: Scripts path
set CREATE_TABLES=scripts\tables\create_tables.sql 
set SEED_COLLECTIONS=scripts\seeds\collections.sql
set SEED_CARDS=scripts\seeds\bulk_cards.sql
set SEED_ATTACKS=scripts\seeds\pokemon_attacks.sql

:: log reset
> log.txt echo Log started at %date% %time%

:: Initial message
echo Executando scripts SQL para o banco %DB_DATABASE%...

:: Verify if database exists
set "DB_EXISTS="
for /f "tokens=*" %%i in ('psql -U %DB_USER% -h %DB_HOST% -p %DB_PORT% -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='%DB_DATABASE%'"') do set DB_EXISTS=%%i

if "%DB_EXISTS%"=="1" (
    echo Banco %DB_DATABASE% ja existe.
) else (
    echo Criando o banco %DB_DATABASE%...
    createdb -U %DB_USER% -h %DB_HOST% -p %DB_PORT% %DB_DATABASE% --encoding=UTF8 --lc-collate=pt_BR.UTF-8 --lc-ctype=pt_BR.UTF-8 --template=template0
    if %ERRORLEVEL% NEQ 0 (
        echo ERRO ao criar o banco %DB_DATABASE%
        goto end
    )
)

:: Execute the scripts
psql -U %DB_USER% -d %DB_DATABASE% -h %DB_HOST% -p %DB_PORT% -f "%CREATE_TABLES%" >> log.txt 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo ERRO ao executar %CREATE_TABLES%
    goto end
)

psql -U %DB_USER% -d %DB_DATABASE% -h %DB_HOST% -p %DB_PORT% -f "%SEED_COLLECTIONS%" >> log.txt 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo ERRO ao executar %SEED_COLLECTIONS%
    goto end
)

psql -U %DB_USER% -d %DB_DATABASE% -h %DB_HOST% -p %DB_PORT% -f "%SEED_CARDS%" >> log.txt 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo ERRO ao executar %SEED_CARDS%
    goto end
)

psql -U %DB_USER% -d %DB_DATABASE% -h %DB_HOST% -p %DB_PORT% -f "%SEED_ATTACKS%" >> log.txt 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo ERRO ao executar %SEED_ATTACKS%
    goto end
)

:: Execute the Powershell with bypass
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_PATH%"

echo Todos os scripts foram executados com sucesso! Veja log.txt para mais detalhes.

:end
pause

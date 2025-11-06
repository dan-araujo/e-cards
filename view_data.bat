@echo off
CALL env.bat
if not exist "%~dp0exports\csv" mkdir "%~dp0exports\csv"
if not exist "%~dp0exports\xlsx" mkdir "%~dp0exports\xlsx"

set "PGPASSWORD=%DB_PASSWORD%"

REM Displays the views
echo -------------------------------
echo Exibindo dados da view cards, para continuar aperte a letra Q...
psql -U %DB_USER% -d %DB_DATABASE% -h %DB_HOST% -p %DB_PORT% -c "SELECT * FROM view_cards;"
echo -------------------------------
echo Exibindo dados da view collections, para continuar aperte a letra Q...
psql -U %DB_USER% -d %DB_DATABASE% -h %DB_HOST% -p %DB_PORT% -c "SELECT * FROM view_collections;"
echo -------------------------------
echo Exibindo dados da view pokemon_attacks, para continuar aperte a letra Q...
psql -U %DB_USER% -d %DB_DATABASE% -h %DB_HOST% -p %DB_PORT% -c "SELECT * FROM view_pokemon_attacks;"

REM Export data to CSV
echo -------------------------------
echo Exportando CSVs...
psql -q -U %DB_USER% -d %DB_DATABASE% -h %DB_HOST% -p %DB_PORT% -c "\COPY (SELECT * FROM view_cards) TO '%~dp0exports\csv\view_cards.csv' WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8';"
psql -q -U %DB_USER% -d %DB_DATABASE% -h %DB_HOST% -p %DB_PORT% -c "\COPY (SELECT * FROM view_collections) TO '%~dp0exports\csv\view_collections.csv' WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8';"
psql -q -U %DB_USER% -d %DB_DATABASE% -h %DB_HOST% -p %DB_PORT% -c "\COPY (SELECT * FROM view_pokemon_attacks) TO '%~dp0exports\csv\view_pokemon_attacks.csv' WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8';"

REM Format everything with PowerShell.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0export_views.ps1"

REM Corrects accentuation by adding BOM to all CSVs (UTF-8 with BOM)
for %%f in (%~dp0exports\csv\*.csv) do (
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "[System.IO.File]::WriteAllBytes('%%~f', (0xEF,0xBB,0xBF) + [System.IO.File]::ReadAllBytes('%%~f'))" >nul 2>&1
)

echo -------------------------------
echo Tudo pronto! Views exibidas e exportadas.
pause

#Pega o diretório atual
$scriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

#Arquivo de saída 
$outputFile = Join-Path -Path $scriptDirectory -ChildPath "migration.sql"

#Remove o arquivo antigo, caso ele já exista
if(Test-Path $outputFile) {
    Remove-Item $outputFile
}

#Pega o conteúdos dos arquivos
$sqlFiles = Get-ChildItem -Path $scriptDirectory -Filter *.sql -File | Sort-Object Name

#Concatena garantindo UTF-8 puro (sem BOM) via StreamWriter
$utf8NoBOM = New-Object System.Text.UTF8Encoding($false)
$writer = New-Object System.IO.StreamWriter($outputFile, $false, $utf8NoBOM)

foreach ($file in $sqlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $writer.WriteLine($content)
    $writer.WriteLine("GO")
}

$writer.Close()

Write-Host "Todos os scripts SQL foram transferidos para $outputFile com sucesso!"
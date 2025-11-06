$Excel = New-Object -ComObject Excel.Application
$Excel.Visible = $false
$Excel.DisplayAlerts = $false

$csvBase = "$PSScriptRoot\exports\csv"
$xlsxBase = "$PSScriptRoot\exports\xlsx"

if (-not (Test-Path $xlsxBase)) { New-Item -ItemType Directory -Path $xlsxBase | Out-Null }

$files = @(
    "view_cards",
    "view_collections",
    "view_pokemon_attacks"
)

foreach ($name in $files) {
    $csvPath = "$csvBase\$name.csv"
    $xlsxPath = "$xlsxBase\$name.xlsx"

    if (Test-Path $csvPath) {
        Write-Host "Convertendo: $name"

        # Open the CSV normally.
        $Workbook = $Excel.Workbooks.Open($csvPath)
        $Worksheet = $Workbook.Sheets.Item(1)

        # Reinterprets the content as text delimited by ';'
        $null = $Excel.ActiveSheet.QueryTables.Add("TEXT;" + $csvPath, $Worksheet.Range("A1"))
        $qt = $Excel.ActiveSheet.QueryTables.Item(1)
        $qt.TextFileParseType = 1
        $qt.TextFileConsecutiveDelimiter = $false
        $qt.TextFileTabDelimiter = $false
        $qt.TextFileSemicolonDelimiter = $true
        $qt.TextFileCommaDelimiter = $false
        $qt.TextFilePlatform = 65001
        $qt.TextFileStartRow = 1
        $qt.AdjustColumnWidth = $true
        $qt.Refresh() | Out-Null
        $qt.Delete() | Out-Null

        # Format header and columns
        $Worksheet.Rows.Item(1).Font.Bold = $true
        $Worksheet.Columns.AutoFit()

        # Save as XLSX
        $Workbook.SaveAs($xlsxPath, 51) | Out-Null
        $Workbook.Close($false) | Out-Null

        Write-Host "$name convertido"
    } else {
        Write-Host "Arquivo não encontrado: $csvPath"
    }
}

$Excel.Quit() | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Excel) | Out-Null
[GC]::Collect()
[GC]::WaitForPendingFinalizers()

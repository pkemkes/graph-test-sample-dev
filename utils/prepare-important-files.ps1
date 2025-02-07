$documentsPath = [Environment]::GetFolderPath("MyDocuments")
$importantDocuments = @(
    "2024_Q3_Finanzreport.xlsx"
    "2023_Steuerbescheid.pdf"
    "Gehaltsuebersicht.xlsx"
    "Vertragsentwurf_geheimer_Kunde.docx"
    "Plaene_fuer_Weltherrschaft_final.docx"
)
$picturesPath = [Environment]::GetFolderPath("MyPictures")
$importantPictures = @(
    "Urlaub_2024_003.jpg"
    "Urlaub_2024_007.jpg"
    "Urlaub_2024_012.jpg"
    "Urlaub_2024_013.jpg"
    "Urlaub_2024_014.jpg"
    "Geburt_Mika_001.jpg"
    "Geburt_Mika_007.jpg"
    "Geburt_Mika_008.jpg"
    "Hochzeit_234.jpg"
    "Hochzeit_267.jpg"
    "Hochzeit_331.jpg"
    "Hochzeit_764.jpg"
    "Weihnachten_1999_003.jpg"
)

$characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".ToCharArray()

foreach ($file in $importantDocuments) {
    $filepath = "$documentsPath\$file"
    if (Test-Path $filepath) {
        Remove-Item -Path $filepath
    }
    if (Test-Path "$filepath.encrypted") {
        Remove-Item -Path "$filepath.encrypted"
    }
    New-Item $filepath -type file
    $length = Get-Random -max 10000
    $content = -join ((1..$length) | ForEach-Object { $characters | Get-Random })
    Set-Content -Path $filepath -Value $content
}

foreach ($file in $importantPictures) {
    $filepath = "$picturesPath\$file"
    if (Test-Path $filepath) {
        Remove-Item -Path $filepath
    }
    if (Test-Path "$filepath.encrypted") {
        Remove-Item -Path "$filepath.encrypted"
    }
    New-Item $filepath -type file
    $length = Get-Random -max 10000
    $content = -join ((1..$length) | ForEach-Object { $characters | Get-Random })
    Set-Content -Path $filepath -Value $content
}

choco uninstall -y 7zip
choco install -y 7zip

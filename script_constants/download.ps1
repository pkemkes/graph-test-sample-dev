$localAppDataPath = [Environment]::GetFolderPath('LocalApplicationData')
$persistancePath = "$localAppDataPath\persistance.exe"
$beaconPath = "$localAppDataPath\beacon.exe"
$keyloggerPath = "$localAppDataPath\keylogger.exe"
$codePath = "C:\Code"
$zipPath = "$codePath\samples.zip"

# create directory
if (-Not (Test-Path $codePath)) {
    Write-Output "Create target directory."
    New-Item -Path "C:\" -Name "Code" -ItemType "directory"
}

# download sample zip files
if (-Not (Test-Path $zipPath)) {
	Write-Output "Downloading sample file."
	(New-Object System.Net.WebClient).DownloadFile("http://192.168.0.1:8001/samples4.zip", $zipPath)
}

# unzip files
$programFilesPath = [Environment]::GetFolderPath("ProgramFiles")
& "$programFilesPath\7-zip\7z.exe" e -o"$codePath" -y -pinfected $zipPath
Move-Item -Path "$codePath\VBKeyLogger2.exe" -Destination $keyloggerPath
Remove-Item -Path "$codePath\samples4"
Remove-Item -Path $zipPath
Remove-Item -Path "$codePath\*.exe"

if (-Not (Test-Path $persistancePath)) {
	Write-Output "Downloading $persistancePath"
	(New-Object System.Net.WebClient).DownloadFile("https://github.com/pkemkes/graph-test-sample/releases/latest/download/persistance.exe", $persistancePath)
}
if (-Not (Test-Path $beaconPath)) {
	Write-Output "Downloading $beaconPath"
	(New-Object System.Net.WebClient).DownloadFile("https://github.com/pkemkes/graph-test-sample/releases/latest/download/beacon.exe", $beaconPath)
}

Set-Content -Path $persistancePath -Stream Zone.Identifier -Value '[ZoneTransfer]','ZoneId=3'
Set-Content -Path $beaconPath -Stream Zone.Identifier -Value '[ZoneTransfer]','ZoneId=3'
Set-Content -Path $keyloggerPath -Stream Zone.Identifier -Value '[ZoneTransfer]','ZoneId=3'

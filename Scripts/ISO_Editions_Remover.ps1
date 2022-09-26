param ($configFile='..\configs\win_editions_remove.txt', $wimfile='I:\sources\install.wim')
foreach ($winedition in Get-Content $configFile){
    Write-Output "Removing Windows $winedition Edition"
	Dism /Delete-Image /ImageFile:$wimfile /Name:$winedition /CheckIntegrity
}

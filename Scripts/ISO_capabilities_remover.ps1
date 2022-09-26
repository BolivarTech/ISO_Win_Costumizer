param ($configFile='..\configs\capabilities_remove.txt', $mountpoint='..\mount')
foreach ($capability in Get-Content $configFile){
    Write-Output "Removing Capabilitie $capability"
	Dism.exe /image:$mountpoint /Remove-Capability /CapabilityName:$capability
}
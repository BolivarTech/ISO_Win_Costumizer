param ($configFile='..\configs\capabilities_add.txt', $mountpoint='..\mount', $sourcePath='I:\sources')
foreach ($capability in Get-Content $configFile){
    Write-Output "Adding Capabilitie $capability"
	Get-WindowsCapability -Path $mountpoint | Where-Object{$_.Name -like "*$capability*" -and $_.State -eq "NotPresent"} | Add-WindowsCapability -Path $mountpoint -Source $sourcePath
}

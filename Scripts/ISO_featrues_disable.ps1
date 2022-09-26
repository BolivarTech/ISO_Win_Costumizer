param ($configFile='..\configs\optionalfeatures_remove.txt', $mountpoint='..\mount')
foreach ($feature in Get-Content $configFile){
    Write-Output "Disabling feature $feature"
	Disable-WindowsOptionalFeature -Path $mountpoint -FeatureName $feature -Remove
}
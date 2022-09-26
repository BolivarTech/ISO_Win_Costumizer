param ($configFile='..\configs\optionalfeatures_add.txt', $mountpoint='..\mount')
foreach ($feature in Get-Content $configFile){
    Write-Output "Enabling feature $feature"
	Enable-WindowsOptionalFeature -Path $mountpoint -FeatureName $feature -All
}
param ($configFile='..\configs\appsRemove.txt', $mountpoint='..\mount')
foreach ($package in Get-Content $configFile){
    Write-Output "Removing Package $package"
	Dism.exe /image:$mountpoint /Remove-ProvisionedAppxPackage /PackageName:$package
}

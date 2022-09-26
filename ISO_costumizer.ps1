param ($mountpoint='.\mount', $wimDrive='I:', $drivesfolder='.\drivers', $configfolder='.\configs')
Write-Output "Removing unused Windows Edition"
.\Scripts\ISO_Editions_Remover.ps1 -configFile "$configfolder\win_editions_remove.txt" -wimfile "$wimDrive\sources\install.wim"
foreach ($winedition in Get-WindowsImage -ImagePath "$wimDrive\sources\install.wim"  | Select-Object -Property ImageIndex){
    $imgIndex = $winedition.ImageIndex
    Write-Output "Mounting Windows Image $imgIndex"
    Mount-WindowsImage -Path $mountpoint -ImagePath "$wimDrive\sources\install.wim" -Index $imgIndex
    Write-Output "Removing Preinstalled Apps"
    .\Scripts\ISO_app_remover.ps1 -configFile .\configs\appsRemove.txt -mountpoint $mountpoint 
    Write-Output "Removing Capabilities"
    .\Scripts\ISO_capabilities_remover.ps1 -mountpoint $mountpoint -configFile .\configs\capabilities_remove.txt
    Write-Output "Adding Capabilities"
    .\Scripts\ISO_capabilities_add.ps1 -mountpoint $mountpoint -configFile .\configs\capabilities_add.txt -sourcePath "$wimDrive\sources"
    Write-Output "Removing Optional Features"
    .\Scripts\ISO_featrues_disable.ps1 -mountpoint $mountpoint -configFile .\configs\optionalfeatures_remove.txt
    Write-Output "Adding Optional Features"
    .\Scripts\ISO_featrues_enable.ps1 -mountpoint $mountpoint -configFile .\configs\optionalfeatures_add.txt
    Write-Output "Adding Drivers"
    .\Scripts\ISO_drivers_Updater.ps1 -mountpoint $mountpoint -drivesfolder $drivesfolder
    Write-Output "Optimizing Windows WIM Installation Image"
    .\Scripts\ISO_Optimize_Commit.ps1 -mountpoint $mountpoint
}
Write-Output "Windows Image Summary"
foreach ($winedition in Get-WindowsImage -ImagePath "$wimDrive\sources\install.wim"  | Select-Object -Property ImageIndex){
    $imgIndex = $winedition.ImageIndex
    Get-WindowsImage -ImagePath "$wimDrive\sources\install.wim" -index $imgIndex
}
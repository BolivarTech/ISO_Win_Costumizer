param ($drivesfolder='..\drivers', $mountpoint='..\mount')
Add-WindowsDriver -Path $mountpoint -Driver $drivesfolder -Recurse

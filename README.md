# Project Details

![OS](https://img.shields.io/badge/OS-Windows-darkgreen)
![licence](https://img.shields.io/badge/language-PowerShell-brightgreen.svg?style=flat-square)
![license](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)

This project is a simple script to customize Windows Instalation Images WIM files in an automatic way.

This poject is provided "AS IS", no waranty, no responsabilities, no more documentation that the one included in this repository, but the scripts are so simples that is don't needed. ;-)

## Dependencies

This scripts use the DISM command to modify a .WIM file. If you are using an older Windows
image that you are making an image for, make sure that you are using the latest
DISM version. To work with Windows 10 install.wim files in other OS versions, you
need to install the Windows ADK (Windows Assessment and Deployment Kit).

You can download the ADK here: [Download and install the Windows ADK](https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install).

If possible, use the ADK version that matches the Windows version you're working with. If your environment has a mix of Windows versions, use the ADK version that matches the latest operating system in your environment.

## Generate Config Files

### Remove other edition in the wim file

Get the list of available Windows editions in the install.wim file:

```PowerShell
Dism /Get-WimInfo /WimFile:"I:\sources\install.wim"  > .\configs\win_editions_remove.txt
```

Edit win_editions_remove.txt and only leave the packge names to remove

### Remove preinstalled apps in the ISO

List installed aplications

```PowerShell
Dism.exe /image:.\mount /Get-ProvisionedAppxPackages > .\configs\appsRemove.txt
```

Edit appRemove.txt and only leave the packge names to remove

Disable or Remove Capabilities & Features

```PowerShell
Get-WindowsCapability -Path .\mount | Where-Object{$_.State -eq "Installed"} > .\configs\capabilities_remove.txt
```

Edit capabilities_remove.txt and only leave the packge names to remove

### Add Capabilities

```PowerShell
Get-WindowsCapability -Path .\mount | Where-Object{$_.State -eq "NotPresent"} > .\configs\capabilities_add.txt
```

Edit capabilities_add.txt and only leave the packge names to add

### Optional Features

Get Windows Enabled Optional Features

```PowerShell
Get-WindowsOptionalFeature -Path .\mount | Where-Object{$_.State -eq "Enabled"} > .\configs\optionalfeatures_remove.txt
```

Edit optionalfeatures_remove.txt and only leave the featrues names to remove

Get Windows Disabled Optional Features

```PowerShell
Get-WindowsOptionalFeature -Path .\mount | Where-Object{$_.State -eq "Disabled"} > .\configs\optionalfeatures_add.txt
```

Edit optionalfeatures_add.txt and only leave the featrues names to add

### Credits

- [Julian Bolivar](https://www.bolivartech.com)

### License

Copyright © [BolivarTech](https://www.bolivartech.com) 2022 All Rights Reserved.

ISO WIM Costumizer © 2022 by [Julian Bolivar](https://www.bolivartech.com) is licensed under [Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/legalcode)

Please see [License File](LICENSE.md) for more information.

param ($mountpoint='..\mount')
DISM /Image:$mountpoint /cleanup-image /StartComponentCleanup /ResetBase
DISM /Image:$mountpoint /Cleanup-Image /ScanHealth
DISM /unmount-wim /mountdir:$mountpoint /commit

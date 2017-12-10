clear
cd $PSScriptRoot
Import-Module D:\GitHub\PSGet-DateName\Get-DateName\Get-DateName.psm1 -Force
Import-Module .\Backup-BookmarksIE.psm1 -Force
Backup-BookmarksIE  "D:\trash\PO3" -verbose 
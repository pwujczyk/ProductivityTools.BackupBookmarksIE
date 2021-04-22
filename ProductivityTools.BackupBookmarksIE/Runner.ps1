clear
cd $PSScriptRoot
Import-Module d:\GitHub\ProductivityTools.PSGetDateName\ProductivityTools.PSGetDateName\ProductivityTools.PSGetDateName.psm1 -Force
Import-Module .\ProductivityTools.BackupBookmarksIE.psm1 -Force
Backup-BookmarksIE  "AutomateBackup" -verbose  -ToDateDirectory -ToPersonalOneDrive
#Restore-BookmarksIE  "D:\xxx\" -FromLastDateDirectory -verbose
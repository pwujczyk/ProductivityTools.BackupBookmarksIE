<!--Category:PowerShell--> 
 <p align="right">
    <a href="https://www.powershellgallery.com/packages/ProductivityTools.BackupBookmarksIE/"><img src="Images/Header/Powershell_border_40px.png" /></a>
    <a href="http://productivitytools.tech/backup-bookmarks-ie/"><img src="Images/Header/ProductivityTools_green_40px_2.png" /><a> 
    <a href="https://github.com/pwujczyk/ProductivityTools.BackupBookmarksIE/"><img src="Images/Header/Github_border_40px.png" /></a>
</p>
<p align="center">
    <a href="http://http://productivitytools.tech/">
        <img src="Images/Header/LogoTitle_green_500px.png" />
    </a>
</p>

# Backup Bookmarks IE

Copy all Internet Explorer bookmarks to the given path.

<!--more-->

Module reads the registry to locate the favorites path and copy all the contents to the given localization. 

![Backup](Images/Backup.png)

Registry key with Favorites property.

![RegistryKey](Images/RegistryKey.png)


```PowerShell
Backup-BookmarksIE -Destination D:\Trash\ 
```

Module allows to use couple of the switches which helps organize backups
- Destination - path where backup should be placed
- ToDateDirectory - if used directory with the date name will be created. Date will have format yyyy.MM.dd.hh.mm.ss. For example 2017.12.02.08.56.16. 
- DateNamePrefix - it allows to add some words before date (checkout example)
- DateNameSuffix - as above
- ToPersonalOneDrive - it will backup favorites to personal one drive. You don't need to provide what is the real OneDrive location
- ToBusinessOneDrive - as above

```PowerShell
Backup-BookmarksIE -Destination D:\Trash\ -ToDateDirectory -DateNamePrefix ie
```

![ResultOfBackup](Images/ResultOfBackup.png)

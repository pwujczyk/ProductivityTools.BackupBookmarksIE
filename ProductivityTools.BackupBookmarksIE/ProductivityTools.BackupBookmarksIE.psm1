function GetFavoritesPath()
{
	$shellFolders=Get-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'
	$favoritesPath=$shellFolders.Favorites
	return $favoritesPath
}

function Backup-BookmarksIE {
	[cmdletbinding()]
	param ([string]$Destination, [switch]$ToDateDirectory, [string]$DateNamePrefix, [string]$DateNameSuffix, 
	[switch]$ToPersonalOneDrive, [switch]$ToBusinessOneDrive)
	
	if (($Destination -eq $null -or $Destination -eq "") -and ($ToPersonalOneDrive.IsPresent -eq $favoritesPath -and $ToBusinessOneDrive.IsPresent -eq $false) )
	{
		throw [System.Exception] "Destination directory is required"
	}

	if ($ToPersonalOneDrive.IsPresent)
	{
		$oneDriveDir=Get-OneDriveDirectory -Personal -JustDirectory
		$Destination=Join-Path $oneDriveDir $Destination
	}

	if ($ToBusinessOneDrive.IsPresent)
	{
		$oneDriveDir=Get-OneDriveDirectory -Business -JustDirectory
		$Destination=Join-Path $oneDriveDir $Destination
	}

	Write-Verbose "Destination directory: $Destination"

	$favoritesPath=GetFavoritesPath

	Write-Verbose "Favorites repository: $favoritesPath"
	$sourceFileCount=(Get-ChildItem -Path $favoritesPath -Recurse).Length

	$destinationDirectory=$Destination
	if ($ToDateDirectory.IsPresent)
	{
		[string]$dateName=Get-DateName -Prefix $DateNamePrefix -Suffix $DateNameSuffix
		$destinationDirectory=Join-Path $Destination $dateName
		Write-Verbose "Destination directory with date directory: $destinationDirectory"
	}

	Write-Verbose "There is $sourceFileCount in the Favorites (source) directory"
	#New-Item -Path $destinationDirectory -Force -ItemType Directory
	
	Copy-ItemDirectoryRepeatable -Recurse -Force -LiteralPath $favoritesPath -Destination $destinationDirectory #-Verbose:$VerbosePreference 
	$destFileCount=(Get-ChildItem -Path $destinationDirectory -Recurse).Length
	Write-Verbose "There is $destFileCount in the Destination (dest) directory"
}

function Restore-BookmarksIE
{
	[cmdletbinding()]
	param ([string]$SourceDirectory, [switch]$FromLastDateDirectory, [string]$DateNamePrefix, [string]$DateNameSuffix)

	if($FromLastDateDirectory.IsPresent)
	{
		$lastDirectory=Get-ChildItem -Path "$SourceDirectory\$DateNamePrefix*$DateNameSuffix" |Select-Object -Last 1
		$SourceDirectory=$lastDirectory
	}

	$sourceFileCount=(Get-ChildItem -Path $SourceDirectory -Recurse).Length
	Write-Verbose "There is $sourceFileCount in the Source directory"

	$favoritesPath=GetFavoritesPath
	#$favoritesPath=$favoritesPath+'2'

	Copy-ItemDirectoryRepeatable -Recurse -Force -LiteralPath $SourceDirectory -Destination $favoritesPath #-Verbose:$VerbosePreference 
	$destFileCount=(Get-ChildItem -Path $favoritesPath -Recurse).Length
	Write-Verbose "There is $destFileCount in the Favorites (dest) directory"
}

Export-ModuleMember Restore-BookmarksIE

Export-ModuleMember Backup-BookmarksIE
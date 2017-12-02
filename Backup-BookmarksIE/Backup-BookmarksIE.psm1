
function Backup-BookmarksIE {

	[cmdletbinding()]
	param ([string]$Destination, [switch]$ToDateDirectory, [string]$DateNamePrefix, [string]$DateNameSuffix)
	
	if ($Destination -eq $null -or $Destination -eq "")
	{
		throw [System.Exception] "Destination directory is required"
	}
	Write-Verbose "Destination directory: $Destination"

	$shellFolders=Get-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'
	$favoritesPath=$shellFolders.Favorites
	$favoritesPath=Join-Path $favoritesPath "\*.*"

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
	Copy-Item -Recurse -Force -Path $favoritesPath -Destination $destinationDirectory #-Verbose:$VerbosePreference
	
	$destFileCount=(Get-ChildItem -Path $destinationDirectory -Recurse).Length
	Write-Verbose "There is $destFileCount in the Destination (dest) directory"
}

Export-ModuleMember Backup-BookmarksIE 
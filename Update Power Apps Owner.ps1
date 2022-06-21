#Prerequisites
#https://docs.microsoft.com/en-us/power-platform/admin/admin-manage-apps#prerequisites

#=================================
#Use as needed
#=================================
#####Errors with the commands?
##Ensure you have Power Apps installed
#Get-InstalledModule -Name 'Microsoft.PowerApps.Administration.PowerShell'
#Get-InstalledModule -Name Microsoft.PowerApps.PowerShell -AllowClobber 

##Ensure there are no policies blocking your PowerShell scripts
#Set-ExecutionPolicy Unrestricted

#####Need your Power Apps Details? Run this to have a CSV export
#$allPowerApps = Get-AdminPowerApp
#write-host -ForegroundColor Magenta "Creating OutputFile..." 

##Update with your filepath
#$filePath = "C:\Power Platform\PowerShell\PowerAppsInventory-"+$currentTime+".csv"    

#Write-Host "Storing file at location: "$filePath
#$allPowerApps | select AppName,DisplayName,EnvironmentName,CreatedTime,LastModifiedTime | Export-Csv -path $filePath
#=================================

#Modules for PowerApps Powershell Commands
#https://docs.microsoft.com/en-us/power-platform/admin/powerapps-powershell
Install-Module -Name Microsoft.PowerApps.Administration.PowerShell 
Install-Module -Name Microsoft.PowerApps.PowerShell -AllowClobber 

#Sign in with the proper account credentials 
Add-PowerAppsAccount

write-host -ForegroundColor Magenta "Let's collect some more details..." 
$AppName = Read-Host "Please enter your App Name"
$newAppOwner = Read-Host "Please enter the New App Owner Email"
$newAppOwnerId = Get-UsersOrGroupsFromGraph -SearchString $newAppOwner
$newAppOwnerId.ObjectId
$EnvironmentName = Read-Host "Please enter the Environment Name"

#Update Power App Owner
write-host -ForegroundColor Magenta "Updating app owner..." 
Set-AdminPowerAppOwner -AppName $AppName -AppOwner $newAppOwnerId.ObjectId -EnvironmentName $EnvironmentName

#Helpful Reference Links:
#https://o365withlalit.wordpress.com/2020/07/01/change-ownership-of-powerapps/
#http://www.evrenayan.net/how-to-change-powerapps-owner-with-powershell/

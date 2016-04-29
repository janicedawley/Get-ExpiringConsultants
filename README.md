## Synopsis

This is a small Powershell script to find expiring consultants within 7 days and email their manager.

##  Configuration

You will need to set a few variables to run this script.

First you will need to fill out the SMTP information at the top of the script:
```powershell

$From = "ITSecurity@domain.com"
$CC = "user@domain.com
$SMTPServer = "smtp.domain.com"
```
As well as setting the OU Path in:
```powershell

$consultants = Get-ADUser -SearchBase "OU=Consultants,DC=corp,DC=com" -Filter { AccountExpirationDate -gt $startdate -and AccountExpirationDate -lt $enddate } -Properties AccountExpirationDate, Manager
```

Users will need to have the Manager field filled out in Active Directory in order for this to work.

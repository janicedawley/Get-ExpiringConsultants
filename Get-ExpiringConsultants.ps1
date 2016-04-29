<#	
	.NOTES
	===========================================================================
	 Created on:   	4/15/2016 2:40 PM
	 Created by:   	Cole Lavallee
	 Filename:     	Get-ExpiringConsultants.ps1
	===========================================================================
	.DESCRIPTION
		Gets all consultant accounts expiring in 7 days and emails the person responsible for that consultant.
#>
# SMTP Information

$From = "ITSecurity@domain.com"
$CC = "user@domain.com
$SMTPServer = "smtp.domain.com"

# Finds users between $startdate (current date) and $enddate (within 7 days of $startdate)

$startdate = (Get-Date)
$enddate = $startdate.AddDays(7)

#Get list of consultants expiring in the next 7 days.

$consultants = Get-ADUser -SearchBase "OU=Consultants,DC=corp,DC=com" -Filter { AccountExpirationDate -gt $startdate -and AccountExpirationDate -lt $enddate } -Properties AccountExpirationDate, Manager

foreach ($consultant in $consultants)
{
	# Get Manager email address
	$Manager = Get-ADUser $consultant.manager -Properties EmailAddress, GivenName
	
	#Set dynamic variables
	$To = $Manager.EmailAddress
	$Subject = "Account Expiration Notification for " + $Consultant.Name
	$Body =
	"Hello $Manager.GivenName,
    This notification is to inform you that the account for $($Consultant.Name) will expire on $($Consultant.AccountExpirationDate).toshortdatestring() 
    If you need to extend this, please contact IT Security at ITSecurity@domain.com.

    Thank you"
	
	Send-MailMessage -To $To -From $From -Cc $CC -Subject $Subject -SmtpServer $SMTPServer -Body $Body
	
	
	
}
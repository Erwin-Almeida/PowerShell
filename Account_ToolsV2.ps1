#Master tool for manageing AD accounts
#Craeted By Erwin Almeida
Import-Module activedirectory

Write-Host " "
Write-Host " Master Tool For Managing AD accounts "
Write-Host " "
Write-Host " Created By Erwin Almeida" 
Write-Host " "
Write-Host " "
Write-Host "Type in the Tool you want to use, For help, type the name of the tool in followed by -help "
Write-Host " "
Write-Host " Locked out | Pass Expired | Set Expiry | RoboCopy | "
$targetfunction = read-host " Please Select one of the above "


If ($targetfunction -eq "Locked out")
{
	Write-Host -NoNewLine $targetfunction
	$targetname = read-host "Target User"
	(Get-Aduser $targetname -Properties LockedOut).LockedOut
	Get-ADUser $targetname -properties LastBAdPasswordAttempt

		

		Write-Host "Unlock Account ? Y/n "
		$unlockdecision = read-host "...."
			IF ($unlockdecision -eq "Y")
				{
					Unlock-AdAccount -Identity $targetname
					Write-Host (Get-Aduser $targetname -Properties LockedOut).LockedOut
				}
			ELSE	
				{		
					Write-Host " Account Stays Locked , stop fat fingering the keyboard "
				}
		

}

ELSEIF ($targetfunction -eq "Pass Expired")
{
	$targetname = read-host "Target User"
	Get-ADUser -Identity $targetname -properties passwordlastset, Passwordneverexpires |ft SamAccountName, passwordlastset, Passwordneverexpires
	
	
}



ELSEIF ($targetfunction -eq "Set Expiry")

{
	$targetname = read-host "Target User"
	$targetdate = read-host "DD/MM/YYYY HH:MM:SS 24 Hour"

	Set-ADAccountExpiration -Identity $targetname -DateTime $targetdate

	Get-ADUser -Identity $targetname -Properties AccountExpirationDate |
	Select-Object -Property SamAccountName, AccountExpirationDate
}

#Help Block

If ($targetfunction -eq "Locked out-help")
{
	Write-Host " Locked out allows a user to type in a username and find out is a user meets the locked out statement. True means yes they are locked out. False means not locked out"
	Write-Host " You are then offered the option to unlock the account or not "
}

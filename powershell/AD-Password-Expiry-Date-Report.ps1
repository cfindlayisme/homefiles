# Generates a CSV file with all full usernames & their password expiry date of of Active Directory
# Change line with Export-csv to proper location for report to go
#
# Author: Chuck Findlay <chuck@findlayis.me>
# License: LGPL v3.0
Import-Module ActiveDirectory

Get-ADUser -filter { Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" | 
Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")} } | 
Export-csv C:\AD-Expiry-Report.csv -NoTypeInformation
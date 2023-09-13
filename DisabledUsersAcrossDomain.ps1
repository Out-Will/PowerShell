#Use to identify disabled users across the domain.
Get-ADUser -Filter {Enabled -eq $false} -Properties Name | Format-Table Name

#Above + export to csv file
Get-ADUser -Filter {Enabled -eq $false} -Properties Name | Export-Csv -Path C:\DisabledUsers.csv -NoTypeInformation

#Transfer disabled users to the "Disabled Users" OU.
$OUTransfer = "OU=DisabledUsers,DC=Adatum,DC=com"
$DisabledUsers = Get-ADUser -Filter {Enabled -eq $false} -Properties Name
$DisabledUsers | Format-Table Name

foreach ($user in $DisabledUsers) {
    Move-ADObject -Identity $user.DistinguishedName -TargetPath $OUTransfer
}

#note to teacher:  hurray it actually works & tested!  I disabled a couple users from a few different OU's and now they're all in the DisabledUsers OU.


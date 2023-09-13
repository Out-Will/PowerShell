Import-Module ActiveDirectory 
 
# Target OU 
$SeachBaseOU = "OU=Managers,DC=Adatum,DC=COM" 
 
# Get all disable Users in the target OU 
$Users=get-aduser -SearchBase $SeachBaseOU -Filter {Enabled -eq "false"} -Properties SAMAccountName,memberOf 
 
# On each user object. 
foreach ($User in $Users){ 
     
    # Get all AD groups where the user is member of. 
    $Groups = $User.memberOf | ForEach-Object { Get-ADGroup $_ }  
 
    # Remove user from each group retrieved above step. 
    foreach ($Group in $Groups){  
 
        Write-Host "Removing " -NoNewline 
        Write-Host $User.SamAccountName -Foreground Green -NoNewline 
        Write-Host " from " -NoNewline 
        Write-Host $Group.Name -ForegroundColor Green 
 
        Remove-ADGroupMember -Identity $Group -Members $User.SAMAccountName -Confirm:$false 
 
    } 
 
}


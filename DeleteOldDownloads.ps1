#Experimenting, doesn't work.  Plus I won't have old files available to delete from the lab environment.

$domain = Read-Host -Prompt 'Enter the domain name'
$OU = Read-Host -Prompt 'Enter the OU name'
$days = Read-Host -Prompt 'Enter the number of days'

Get-ADComputer -Filter * -SearchBase "OU=$OU,DC=$adatum,DC=com" | ForEach-Object {
    $computerName = $_.Name
    $path = "\\$computerName\c$\Users\*\Downloads"
    $files = Get-ChildItem $path -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$days) }
    if ($files) {
        Write-Host "Deleting files on $computerName"
        $files | Remove-Item -Force
    }
}
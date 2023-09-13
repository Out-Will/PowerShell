#Retrieve disc size and amout of free space on a remote host.

$computerName = Read-Host -Prompt 'Enter the remote host name'
Get-WmiObject -Class Win32_LogicalDisk -ComputerName $computerName | Select-Object DeviceID, VolumeName, @ {Label='FreeSpace (Gb)'; expression= { ($_.FreeSpace/1GB).ToString ('F2')}}, @ {Label='Total (Gb)'; expression= { ($_.Size/1GB).ToString ('F2')}}
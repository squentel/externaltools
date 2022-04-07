Get-Service -Name VSS |Select DisplayName,Status,StartType|Format-List |Out-String| ForEach-Object { $_.Trim()};

#Enable Restore
Enable-ComputerRestore -Drive “C:\”;
Set-Service -Name VSS -StartupType Automatic;
Start-Service -Name VSS;

#Create Scheduled Tasks
$Trigger= New-ScheduledTaskTrigger -At 08:00am –Daily # Specify the trigger settings
$User= "NT AUTHORITY\SYSTEM" # Specify the account to run the script
$Action= New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "C:\vss.ps1" # Specify what program to run and with its parameters
Register-ScheduledTask -TaskName "VSSCopy" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest –Force # Specify the name of the task

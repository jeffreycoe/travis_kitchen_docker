Write-Host "Configuring Docker service to listen on TCP port 2375..."
$configFile = "C:\ProgramData\Docker\config\daemon.json"
$config = (Get-Content $configFile | ConvertFrom-Json)
$config | Add-Member -Type NoteProperty -Name "hosts" -Value @("tcp://0.0.0.0:2375")
$config | ConvertTo-Json | Set-Content $configFile

Restart-Service docker -Force -Verbose

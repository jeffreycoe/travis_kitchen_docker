Write-Host "Configuring Docker service to listen on TCP port 2375..."
$dockerSvcBinPath = (Get-WmiObject Win32_Service | ?{$_.Name -eq 'docker'} | Select PathName).PathName
$dockerSvcBinPath = "$dockerSvcBinPath -H tcp://0.0.0.0:2375 -H npipe:////./pipe/docker_engine"
Write-Host "Docker Service Path: $dockerSvcBinPath"

Get-WmiObject Win32_Service -Filter "Name='docker'" | Invoke-WmiMethod -Name Change -ArgumentList @($null,$null,$null,$null,$null, $dockerSvcBinPath) | Out-Null

Restart-Service docker -Force -Verbose
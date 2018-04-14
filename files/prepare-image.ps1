$keysFile = [io.path]::combine($env:ProgramData, 'ssh', 'authorized_keys')
Remove-Item -Recurse -Force -Path $keysFile

Enable-ScheduledTask "Download Key Pair"

echo "Running InitializeInstance"
& Powershell.exe C:/ProgramData/Amazon/EC2-Windows/Launch/Scripts/InitializeInstance.ps1 -Schedule
if ($LASTEXITCODE -ne 0) {
	throw("Failed to run InitializeInstance")
}

echo "Running Sysprep Instance"
& Powershell.exe C:/ProgramData/Amazon/EC2-Windows/Launch/Scripts/SysprepInstance.ps1 -NoShutdown
if ($LASTEXITCODE -ne 0) {
	throw("Failed to run Sysprep")
}


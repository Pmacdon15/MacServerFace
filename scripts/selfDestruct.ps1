# Function to display a progress bar with a red progress bar
function Show-ProgressBar {
    param (
        [int]$Progress,
        [int]$Total
    )

    $Percentage = ($Progress / $Total) * 100
    $ProgressBarWidth = [math]::Round(($Percentage / 2), 0)
    $ProgressBar = "[" + "-" * $ProgressBarWidth + (" " * (50 - $ProgressBarWidth)) + "] $Percentage%"

    # Sleep for 100ms to allow the screen to update
    Start-Sleep -Milliseconds 100
    # Clear the screen
    Clear-Host
    
    Write-Host "Self Destruct in progress..."  
    Write-Host "Please Stand back there will be a large bang..."  
    Write-Host $ProgressBar -ForegroundColor Red
}

# Set the total number of steps (you can change this)
$TotalSteps = 100

# Simulate progress by incrementing a counter (you can replace this with your own logic)
for ($i = 0; $i -lt $TotalSteps; $i++) {
    Show-ProgressBar -Progress $i -Total $TotalSteps
    Start-Sleep -Milliseconds 100  # Simulate some work being done
}

Write-Host "Bang!!!!!!!" -ForegroundColor Red
Start-Sleep -Milliseconds 1000
Write-Host "Self Destruct Complete" -ForegroundColor Red
Start-Sleep -Milliseconds 1000
Write-Host "Have a nice day" -ForegroundColor Red
Start-Sleep -Milliseconds 1000
Write-Host "Goodbye" -ForegroundColor Red
Start-Sleep -Milliseconds 1000
Write-Host "..." -ForegroundColor Red

exit
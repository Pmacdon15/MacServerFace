# Hide all windows
$null = (New-Object -ComObject Shell.Application).MinimizeAll()

# Specify the YouTube URL for the "Rick Roll" video
$url = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

# Start Microsoft Edge with the specified URL
Start-Process "msedge.exe" -ArgumentList $url

# Wait for Microsoft Edge to load (you can adjust the sleep duration as needed)
Start-Sleep -Seconds 3

# Create a COM object for shell automation
$wshell = New-Object -ComObject wscript.shell

# Activate Microsoft Edge (you might need to adjust this title)
$wshell.AppActivate('YouTube - Microsoft Edge')

# Send the F11 key to toggle full-screen mode
$wshell.SendKeys('{F11}')

exit
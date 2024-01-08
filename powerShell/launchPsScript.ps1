# Enter this in to powershell to Execute a Powershell script from the remote server. Replace <scriptname> with the name of the script you want to execute.

Invoke-Expression ([System.Text.Encoding]::UTF8.GetString((Invoke-WebRequest -Uri "http://localhost:3002/scripts/qrcode.ps1" -UseBasicParsing).Content))


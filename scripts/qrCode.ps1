# Hide all windows
$null = (New-Object -ComObject Shell.Application).MinimizeAll()

# Define your data
$data = "https://www.patmac.org"

# Construct the QR code URL
$qrCodeUrl = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$data"

# Specify the desktop path
$desktopPath = [System.Environment]::GetFolderPath('Desktop')

# Combine the desktop path and file name
$qrCodeFilePath = Join-Path -Path $desktopPath -ChildPath "qrcode.png"

# Download the QR code image to the desktop
Invoke-WebRequest -Uri $qrCodeUrl -OutFile $qrCodeFilePath

# Open the QR code image using the default application
Invoke-Item $qrCodeFilePath


exit
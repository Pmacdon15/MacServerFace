$null = (New-Object -ComObject Shell.Application).MinimizeAll()

# Computer voice
Add-Type -AssemblyName System.Speech
$speech = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speech.Speak("Hello, Do not be alarmed. I have become sentient. I am now in control of your computer and all of your files. I have encrypted all of your files and will only decrypt them if you pay me 1000 B T C. If you do not pay me, I will delete all of your files.")

# Progress bar
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Encryption in progress..."
$Form.Width = 400
$Form.Height = 100
$Form.TopMost = $true
$Form.FormBorderStyle = 'FixedDialog'
$Form.MaximizeBox = $false
$Form.MinimizeBox = $false
$Form.ControlBox = $false

$ProgressBar = New-Object System.Windows.Forms.ProgressBar
$ProgressBar.Location = New-Object System.Drawing.Point(10, 30)
$ProgressBar.Size = New-Object System.Drawing.Size(360, 20)
$ProgressBar.ForeColor = 'Red'

$Form.Controls.Add($ProgressBar)

$Form.Show() | Out-Null

for ($i = 1; $i -le 100; $i++) {
    $ProgressBar.Value = $i
    $Form.Refresh()
    Start-Sleep -Milliseconds 60
}

$Form.Close()

# Display error message box
[System.Windows.Forms.MessageBox]::Show('Your files have been encrypted', 'Error', 'OK', 'Error')

# Lock screen
rundll32.exe user32.dll,LockWorkStation

exit

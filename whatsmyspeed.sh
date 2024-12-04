#!/bin/bash

# Run speedtest and capture the output
speedtest_output=$(speedtest-cli --simple)

# Extract server location, download, and upload speeds from the output
server=$(echo "$speedtest_output" | grep "Server" | awk -F: '{print $2}')
download_speed=$(echo "$speedtest_output" | grep "Download" | awk '{print $2}' | sed 's/Mbit//')
upload_speed=$(echo "$speedtest_output" | grep "Upload" | awk '{print $2}' | sed 's/Mbit//')

# Get the current date and time
date_time=$(date '+%Y-%m-%d %H:%M:%S')

# Log file location
log_file="speedtest.log"

# Write to log file
echo "[$date_time] Server: $server | Download: ${download_speed}Mbit/s | Upload: ${upload_speed}Mbit/s" >> "$log_file"

# Provide a recommendation based on download speed
if (( $(echo "$download_speed < 40" | bc -l) )); then
    echo "Your speed is terrible! Yell at your ISP right now!"
else
    echo "Your speed is acceptable. Keep up the good work!"
fi

# Optionally, output the results
# Comment out the line below to disable output in Terminal
echo "$speedtest_output"


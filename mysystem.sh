#!/bin/bash
clear
echo "This is information provided by mysystem.sh."

echo "Hello, $USER"
echo

echo "Today's date is `date`, this is week `date +"%V"`."
echo

echo "These users are currently connected:"
w
# w | cut -d " " -f 1 - | grep -v USER | sort -u
echo

printf "This is `uname -s` running on a `uname -m` processor.\n"
printf "\n"

printf "This is the uptime information:\n"
uptime
printf "\n"

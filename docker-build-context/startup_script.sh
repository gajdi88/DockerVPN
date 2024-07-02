#!/bin/bash
# This file needs to be an executable shell script

# write the outputs of the script to a log file
exec > >(tee /var/log/startup_script.log) 2>&1

# read nordvpn token from txt
token=$(</root/token.txt)

# This script is used to start the NordVPN service and connect to a specific server
nordvpn login --token "$token"

nordvpn set killswitch 1
nordvpn set analytics 0
nordvpn whitelist add subnet 192.168.0.0/24
sleep 5
nordvpn c
sleep 5
nordvpn d
sleep 5
nordvpn c Netherlands

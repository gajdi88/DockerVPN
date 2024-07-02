#!/bin/bash
# This file needs to be an executable shell script
# Start the NordVPN service
/etc/init.d/nordvpn start

# Add a delay to ensure the service starts properly
sleep 5
# diagnostics -----------------

# Check the status of the NordVPN service
#/etc/init.d/nordvpn status

# Verify if the socket file is created
if [ -e /run/nordvpn/nordvpnd.sock ]; then
    echo "NordVPN service started successfully."
else
    echo "NordVPN service failed to start. /run/nordvpn/nordvpnd.sock not found."
    exit 1
fi


# -------------------------
# read nordvpn token from txt
token=$(</root/token.txt)

# This script is used to start the NordVPN service and connect to a specific server
nordvpn login --token "$token"

nordvpn set killswitch 1
nordvpn set analytics 0
nordvpn whitelist add subnet 192.168.0.0/24
sleep 5

#echo "Attempting to connect to NordVPN..."
#nordvpn connect --log --debug
#if [ $? -ne 0 ]; then
#    echo "NordVPN connection failed. Debug logs:"
#    nordvpn logs
#    exit 1
#fi


# previous connect
nordvpn c
sleep 5
nordvpn d
sleep 5
nordvpn c Netherlands

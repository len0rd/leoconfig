#!/bin/sh
# automatically mount shared drives upon connection to the company network

ARA_UUID="d5788b6e-8fac-4f6c-9a3c-a3b03d576b5"

# Find the connection UUID with "nmcli connection show" in terminal.
# All NetworkManager connection types are supported: wireless, VPN, wired...
if [ "$2" = "up" ]; then
    if [ "$CONNECTION_UUID" = "$ARA_UUID" ]; then
        PASSWORD=$(kwalletcli -f Passwords -e aranet)
        mount -t cifs //172.16.29.106/ara-eng /mnt/ara_v -o username=tmiller,password=$PASSWORD,domain=SALES
    fi
fi

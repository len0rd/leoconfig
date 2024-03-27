#!/bin/sh
# attempt unmount of company shared drives upon unexpected-disconnect to the company network

ARA_UUID="d5788b6e-8fac-4f6c-9a3c-a3b03d576b5"

if [ "$CONNECTION_UUID" = "$ARA_UUID" ]; then
    if [ "$2" = "down" ]; then
        umount -a -l -t cifs
    fi
fi


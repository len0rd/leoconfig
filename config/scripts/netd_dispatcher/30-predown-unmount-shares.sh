#!/bin/sh
# automatically unmount company shared drives upon software-disconnect to the company network

ARA_UUID="d5788b6e-8fac-4f6c-9a3c-a3b03d576b5"

if [ "$CONNECTION_UUID" = "$ARA_UUID" ]; then
    umount -a -l -t cifs
fi


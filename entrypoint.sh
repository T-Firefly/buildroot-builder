#!/bin/bash

USER=firefly
ID=${USER_ID:-1000}

if [ $ID -eq `id -u` ]; then
    exec "$@"
else
    useradd --shell /bin/bash -u $ID $USER
    exec gosu $USER "$@"
fi

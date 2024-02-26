#!/bin/bash
###-------------------------------------------------------------------
### Author: Lukasz Opiola
### Copyright (C): 2024 ACK CYFRONET AGH
### This software is released under the MIT license cited in 'LICENSE.txt'.
###-------------------------------------------------------------------
### Constants and functions used in the demo mode related scripts.
###-------------------------------------------------------------------

export ONEZONE_DOMAIN="onezone.local"  # this is put in /etc/hosts to make it resolvable

exit_and_kill_docker() {
    >&2 echo -e "\e[1;31m"
    >&2 echo "-------------------------------------------------------------------------"
    >&2 echo "ERROR: Unrecoverable failure, killing the docker in 10 seconds."
    >&2 echo "-------------------------------------------------------------------------"
    >&2 echo -e "\e[0m"

    sleep 10

    kill -9 "$(pgrep -f /root/oneprovider.py)"
    exit 1
}

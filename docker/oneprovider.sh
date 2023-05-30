#!/bin/bash

source /root/internal-scripts/common.sh

# @TODO VFS-10947-make-sure-onezone-oneprovider-entrypoint-is-started-with-pid-1

function on_termination_signal {
    dispatch-log "Received a termination signal"
    /root/internal-scripts/oneprovider-ensure-stopped.sh
    dispatch-log "Main process exiting"
}

trap on_termination_signal SIGHUP SIGINT SIGTERM

# make sure the graceful stop marker is not set; see common.sh
rm -f ${GRACEFUL_STOP_LOCK_FILE}

# must be done before dispatch-log, which writes to a persistent directory
/root/persistence-dir.py --copy-missing-files

dispatch-log "Main process starting" extra_linebreak_in_log_file

/root/oneprovider.py &
wait $!

#!/bin/bash

set -euo pipefail

source /etc/talsen/util/detect-script-dir.bash

DOJO_DIR=$( detect_script_dir ${BASH_SOURCE[0]} )

function print_help() {
    local COMMAND_DIR="${DOJO_DIR}/command"

    for COMMAND in $( cd ${COMMAND_DIR} && ls *.bash )
    do
        /bin/bash ${COMMAND_DIR}/${COMMAND}
    done
}

if [ ${#} = 0 ];
then
    print_help

    exit 0
fi

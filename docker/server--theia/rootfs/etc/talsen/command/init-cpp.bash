#!/bin/bash

set -euo pipefail

source /etc/talsen/util/detect-command-name.bash

SCRIPT_NAME=$( detect_command_name ${0} )

function print_help() {
    echo "Usage: dojo ${SCRIPT_NAME}"
    echo "--> Initializes an empty workspace with the C++ template."
}

if [ ${#} = 0 ];
then
    print_help

    exit 0
fi

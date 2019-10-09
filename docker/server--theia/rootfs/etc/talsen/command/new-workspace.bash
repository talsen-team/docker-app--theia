#!/bin/bash

set -euo pipefail

source /etc/talsen/util/detect-command-name.bash

SCRIPT_NAME=$( detect_command_name ${0} )
WORKSPACE_NAME_PREFIX=$( date +%F )

function print_help() {
    echo "Usage: dojo ${SCRIPT_NAME} <name>"
    echo "Creates a new empty dojo workspace."
    echo "  <name>: Will have the current date prepended, the full name"
    echo "          looks like the following: \"${WORKSPACE_NAME_PREFIX}-<name>\""
    echo ""
}

if [ ${#} = 0 ];
then
    print_help

    exit 0
fi

#!/bin/bash

set -euo pipefail

source /etc/talsen/util/detect-command-name.bash
source /etc/talsen/util/detect-help-flag.bash
source /etc/talsen/util/print-help-flag-text.bash

source /etc/talsen/util/indicator/workspace-indicator.bash
source /etc/talsen/util/indicator/workspace-raw-name-indicator.bash
source /etc/talsen/util/indicator/workspace-template-indicator.bash

SCRIPT_NAME=$( detect_command_name ${0} )

function print_help() {
    echo "Usage: dojo ${SCRIPT_NAME}"
    print_help_flag_text
    echo "--> Builds an initialized workspace."
}

if [ $( detect_help_flag ${@:1} ) = 1 ];
then
    print_help

    exit 0
fi

if [ ! -d ${WORKSPACE_INDICATOR} ];
then
    echo "Error: \"${PWD}\" is not a workspace directory."

    exit 1
elif [ ! -f ${WORKSPACE_TEMPLATE_INDICATOR} ];
then
    echo "Error: Workspace \"$( cat ${WORKSPACE_RAW_NAME_INDICATOR} )\" is not initialized yet."

    exit 1
else
    exit 0
fi

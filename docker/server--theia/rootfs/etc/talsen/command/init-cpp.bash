#!/bin/bash

set -euo pipefail

source /etc/talsen/util/detect-command-name.bash
source /etc/talsen/util/detect-help-flag.bash
source /etc/talsen/util/print-help-flag-text.bash

ASSET_CPP_TEMPLATE=/etc/talsen/assets/cpp-template

PWD=$( pwd )
SCRIPT_NAME=$( detect_command_name ${0} )

function print_help() {
    echo "Usage: dojo ${SCRIPT_NAME}"
    print_help_flag_text
    echo "--> Initializes an empty workspace with the C++ template."
}

if [ $( detect_help_flag ${@:1} ) = 1 ];
then
    print_help

    exit 0
fi

WORKSPACE_INDICATOR=.workspace
WORKSPACE_RAW_NAME_INDICATOR=.workspace/.raw-name
WORKSPACE_TEMPLATE_INDICATOR=.workspace/.template

if [ ! -d ${WORKSPACE_INDICATOR} ];
then
    echo "Error: \"${PWD}\" is not a workspace directory."
elif [ -f ${WORKSPACE_TEMPLATE_INDICATOR} ];
then
    echo "Error: Workspace \"$( cat ${WORKSPACE_RAW_NAME_INDICATOR} )\" is already initialized as \"$( cat ${WORKSPACE_TEMPLATE_INDICATOR} )\" workspace."
else
    rsync --archive              \
          ${ASSET_CPP_TEMPLATE}/ \
          .

    echo "--> Workspace has been initialized with \"$( cat ${WORKSPACE_TEMPLATE_INDICATOR} )\" template."
fi

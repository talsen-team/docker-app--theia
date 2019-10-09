#!/bin/bash

set -euo pipefail

source /etc/talsen/util/detect-command-name.bash

ASSET_NEW_WORKSPACE=/etc/talsen/assets/new-workspace

SCRIPT_NAME=$( detect_command_name ${0} )
WORKSPACE_NAME_PREFIX=$( date +%F )

function print_help() {
    echo "Usage: dojo ${SCRIPT_NAME} <name>"
    echo "  <name>: Will have the current date prepended, the full name"
    echo "          looks like the following: \"${WORKSPACE_NAME_PREFIX}-<name>\""
    echo "--> Creates a new empty dojo workspace."
    echo ""
}

if [ ${#} = 0 ];
then
    print_help

    exit 0
fi

WORKSPACE_NAME=${1}
WORKSPACE_DIR=/home/project/${WORKSPACE_NAME_PREFIX}-${WORKSPACE_NAME}

if [ -d ${WORKSPACE_DIR} ];
then
    echo "Error: Another workspace at \"${WORKSPACE_DIR}\" already exists."

    exit 1
elif [[ ${WORKSPACE_NAME} =~ ^[-_0-9a-zA-Z]+$ ]]
then
    cp --archive              \
       ${ASSET_NEW_WORKSPACE} \
       ${WORKSPACE_DIR}

    echo ${WORKSPACE_NAME} > ${WORKSPACE_DIR}/.workspace/.raw-name

    echo "--> A new empty workspace has been created at \"${WORKSPACE_DIR}\"."
    echo "    Open it in theia to proceed."

    exit 0
else
    echo "Error: The workspace name \"${WORKSPACE_NAME}\" is invalid"

    exit 1
fi

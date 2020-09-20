#!/bin/bash

set -euo pipefail

source /etc/talsen/util/detect-command-name.bash
source /etc/talsen/util/detect-help-flag.bash
source /etc/talsen/util/print-help-flag-text.bash

source /etc/talsen/util/indicator/workspace-name.bash

source /etc/talsen/config/workspace-base-url.editor.bash

ASSET_NEW_WORKSPACE=/etc/talsen/assets/new-workspace

SCRIPT_NAME=$( detect_command_name ${0} )
WORKSPACE_NAME_SUFFIX=$( date +%F )

function print_help() {
    echo "Usage: dojo ${SCRIPT_NAME} <origin> <name>"
    echo "  <origin>: Path to the workspace to duplicate"
    echo "  <name>:   Will have the current date appended, the full name"
    echo "            looks like the following: \"<name>-${WORKSPACE_NAME_SUFFIX}\""
    print_help_flag_text
    echo "--> Duplicates an existing dojo workspace."
}

if [[ ${#} != 2 ]] || [[ $( detect_help_flag ${@:1} ) = 1 ]];
then
    print_help

    exit 0
fi

WORKSPACE_ORIGIN=${1}
WORKSPACE_NAME=${2}
WORKSPACE_DIR=/home/project/${WORKSPACE_NAME}-${WORKSPACE_NAME_SUFFIX}
WORKSPACE_URL=${WORKSPACE_BASE_URL}${WORKSPACE_NAME}-${WORKSPACE_NAME_SUFFIX}

if [ -d ${WORKSPACE_DIR} ];
then
    echo "Error: Another workspace at \"${WORKSPACE_URL}\" already exists."

    exit 1
elif [[ ! ${WORKSPACE_NAME} =~ ^[-_0-9a-zA-Z]+$ ]]
then
    echo "Error: The workspace name \"${WORKSPACE_NAME}\" is invalid."

    exit 1
elif [ ! -f ${WORKSPACE_ORIGIN}/${WORKSPACE_NAME_INDICATOR} ];
then
    echo "Error: The workspace origin \"${WORKSPACE_ORIGIN}\" is invalid."

    exit 1
fi

cp --archive            \
    ${WORKSPACE_ORIGIN} \
    ${WORKSPACE_DIR}

echo ${WORKSPACE_NAME} > ${WORKSPACE_DIR}/${WORKSPACE_NAME_INDICATOR}

echo "--> The workspace \"${WORKSPACE_ORIGIN}\" has been duplicated at:"
echo "      ${WORKSPACE_URL}"

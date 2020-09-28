#!/bin/bash

set -euo pipefail

source /etc/talsen/util/detect-command-name.bash
source /etc/talsen/util/detect-help-flag.bash
source /etc/talsen/util/print-help-flag-text.bash

source /etc/talsen/util/indicator/workspace-name.bash

source /etc/talsen/config/clone-base-url.bash
source /etc/talsen/config/workspace-base-url.editor.bash

ASSET_NEW_WORKSPACE=/etc/talsen/assets/new-workspace

SCRIPT_NAME=$( detect_command_name ${0} )
WORKSPACE_NAME_SUFFIX=$( date +%F )

function print_help() {
    echo "Usage: dojo ${SCRIPT_NAME} <path>"
    echo "  <path>: The workspace path to clone from, the created workspace"
    echo "          looks like the following: \"<name>-${WORKSPACE_NAME_SUFFIX}\""
    print_help_flag_text
    echo "--> Clones a workspace from \"${CLONE_BASE_URL}\"."
}

if [[ ${#} = 0 ]] || [[ $( detect_help_flag ${@:1} ) = 1 ]];
then
    print_help

    exit 0
fi

WORKSPACE_PATH_REL=${1}
WORKSPACE_NAME=${1##*\/}
WORKSPACE_PATH_SRC=${CLONE_BASE_URL}/${WORKSPACE_PATH_REL}.git
WORKSPACE_DIR=/home/project/${WORKSPACE_NAME}-${WORKSPACE_NAME_SUFFIX}
WORKSPACE_URL=${WORKSPACE_BASE_URL}${WORKSPACE_NAME}-${WORKSPACE_NAME_SUFFIX}

if [[ ! ${WORKSPACE_NAME} =~ ^[-_0-9a-zA-Z]+$ ]]
then
    echo "Error: The workspace name \"${WORKSPACE_NAME}\" is invalid."

    exit 1
fi

COUNT=1
while [ -d ${WORKSPACE_DIR} ];
do
    WORKSPACE_DIR=/home/project/${WORKSPACE_NAME}${COUNT}-${WORKSPACE_NAME_SUFFIX}
    WORKSPACE_URL=${WORKSPACE_BASE_URL}${WORKSPACE_NAME}${COUNT}-${WORKSPACE_NAME_SUFFIX}
    ((COUNT++))
done

git clone --recurse-submodules \
    ${WORKSPACE_PATH_SRC}      \
    ${WORKSPACE_DIR}

for ITEM in $( find ${ASSET_NEW_WORKSPACE} -mindepth 1 -maxdepth 1 )
do
    cp --archive --force \
        ${ITEM}          \
        ${WORKSPACE_DIR}
done

echo ${WORKSPACE_NAME} > ${WORKSPACE_DIR}/${WORKSPACE_NAME_INDICATOR}

echo "--> A workspace has been cloned from:"
echo "      ${WORKSPACE_PATH_SRC}"
echo "    to:"
echo "      ${WORKSPACE_URL}"

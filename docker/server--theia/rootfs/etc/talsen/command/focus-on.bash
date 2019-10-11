#!/bin/bash

set -euo pipefail

source /etc/talsen/util/detect-command-name.bash
source /etc/talsen/util/detect-help-flag.bash
source /etc/talsen/util/print-help-flag-text.bash

SCRIPT_NAME=$( detect_command_name ${0} )

FOCI=""
for FOCUS in $( find /etc/talsen/focus/ -maxdepth 1 -name *.foci -type f -printf '%f ' | xargs echo )
do
    FOCI="${FOCI}${FOCUS} "
done
FOCI="${FOCI}"

function print_help() {
    echo "Usage: dojo ${SCRIPT_NAME} <focus>"
    echo "  <focus>: The focus to set, supported foci are:"

    for FOCUS in ${FOCI}
    do
        FOCI_FOR=""
        while IFS= read -r FOCUS_FOR
        do
            FOCI_FOR="${FOCI_FOR}${FOCUS_FOR} "
        done <<< $( cat /etc/talsen/focus/${FOCUS} )
    echo "           ${FOCUS/.foci/}: ${FOCI_FOR}"
    done

    print_help_flag_text
    echo "--> Sets a new focus for the workspace build."
}

if [ $( detect_help_flag ${@:1} ) = 1 ];
then
    print_help

    exit 0
fi

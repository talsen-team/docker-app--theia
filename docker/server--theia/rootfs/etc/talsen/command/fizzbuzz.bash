#!/bin/bash

set -euo pipefail

source /etc/talsen/util/detect-command-name.bash
source /etc/talsen/util/detect-help-flag.bash
source /etc/talsen/util/print-help-flag-text.bash

SCRIPT_NAME=$( detect_command_name ${0} )

function print_help() {
    echo "Usage: dojo ${SCRIPT_NAME}"
    print_help_flag_text
    echo "--> Clones the fizzbuzz template workspace."
}

if [[ $( detect_help_flag ${@:1} ) = 1 ]];
then
    print_help

    exit 0
fi

dojo clone templates/fizzbuzz

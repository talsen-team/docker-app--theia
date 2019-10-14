#!/bin/bash

set -euo pipefail

source /etc/talsen/util/indicator/workspace-template.bash

CHEAT_SHEET_TARGET=.cheats
MOQ_CHEAT_SHEET_TEMPLATE=/etc/talsen/assets/cheat-sheets/.moq
NUNIT_CHEAT_SHEET_TEMPLATE=/etc/talsen/assets/cheat-sheets/.nunit

mkdir --parents             \
      ${CHEAT_SHEET_TARGET}

rsync --archive                     \
        ${MOQ_CHEAT_SHEET_TEMPLATE} \
        ${CHEAT_SHEET_TARGET}

rsync --archive                       \
        ${NUNIT_CHEAT_SHEET_TEMPLATE} \
        ${CHEAT_SHEET_TARGET}

echo "--> Cheat sheets for \"$( cat ${WORKSPACE_TEMPLATE_INDICATOR} )\" template have been imported to \"${CHEAT_SHEET_TARGET}\"."

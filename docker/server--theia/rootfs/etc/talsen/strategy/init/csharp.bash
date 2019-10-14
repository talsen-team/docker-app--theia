#!/bin/bash

set -euo pipefail

source /etc/talsen/util/indicator/workspace-template.bash

ASSET_TEMPLATE=/etc/talsen/assets/csharp-template

rsync --archive            \
        ${ASSET_TEMPLATE}/ \
        .

echo "--> Workspace has been initialized with \"$( cat ${WORKSPACE_TEMPLATE_INDICATOR} )\" template."

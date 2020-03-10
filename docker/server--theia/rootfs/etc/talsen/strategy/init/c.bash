#!/bin/bash

set -euo pipefail

source /etc/talsen/util/indicator/workspace-template.bash

ASSET_TEMPLATE=/etc/talsen/assets/c-template

rsync --archive            \
        ${ASSET_TEMPLATE}/ \
        .

rm src/.gitkeep
rm test/support/.gitkeep

ceedling module:create[dummy] \
> /dev/null

echo "--> Workspace has been initialized with \"$( cat ${WORKSPACE_TEMPLATE_INDICATOR} )\" template."

#!/bin/bash

set -euo pipefail

source /etc/talsen/util/indicator/workspace-template.bash

echo "--> There are no cheat sheets for \"$( cat ${WORKSPACE_TEMPLATE_INDICATOR} )\" template defined yet. If you have good examples for jest tests showing relevant functionality in a descriptive way please send them via mail. Thx !! ;-)"

#!/bin/bash

set -euo pipefail

source /etc/talsen/util/indicator/workspace-gunit-src.bash
source /etc/talsen/util/indicator/workspace-template.bash

ASSET_TEMPLATE=/etc/talsen/assets/cpp-template

rsync --archive            \
        ${ASSET_TEMPLATE}/ \
        .

rsync --archive                        \
      ${WORKSPACE_GUNIT_SRC_INDICATOR} \
      .

echo "--> Workspace has been initialized with \"$( cat ${WORKSPACE_TEMPLATE_INDICATOR} )\" template."

#!/bin/bash

set -euo pipefail

source /etc/talsen/util/indicator/workspace-gunit-lib-indicator.bash
source /etc/talsen/util/indicator/workspace-meson-options-indicator.bash

BUILD_DIR=.build
PWD=$( pwd )
TARGET_NAME=run-workspace

if [ ! -d ${BUILD_DIR} ];
then
    cat ${WORKSPACE_MESON_OPTIONS_INDICATOR} \
    > meson_options.txt
    echo "option( 'exe_name', type : 'string', value : '${TARGET_NAME}' )" \
    >> meson_options.txt
    echo "option( 'gunit_lib_dir', type : 'string', value : '$( pwd )/${WORKSPACE_GUNIT_LIB_INDICATOR}' )" \
    >> meson_options.txt

    meson ${BUILD_DIR}
fi

cd ${BUILD_DIR}

echo ""

ninja

echo ""

./${TARGET_NAME}

cd ${PWD}

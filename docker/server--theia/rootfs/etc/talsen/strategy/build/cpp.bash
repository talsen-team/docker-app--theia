#!/bin/bash

set -euo pipefail

BUILD_DIR=.build
PWD=$( pwd )
TARGET_NAME=run-workspace

if [ ! -d ${BUILD_DIR} ];
then
    echo "" \
    > meson_options.txt
    echo "option( 'exe_name', type : 'string', value : '${TARGET_NAME}' )" \
    >> meson_options.txt
    echo "option( 'gunit_lib_dir', type : 'string', value : '$( pwd )/.workspace/.gunit/lib' )" \
    >> meson_options.txt

    meson ${BUILD_DIR}
fi

cd ${BUILD_DIR}

echo ""

ninja

echo ""

./${TARGET_NAME}

cd ${PWD}

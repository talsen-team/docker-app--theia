#!/bin/bash

set -euo pipefail

BUILD_DIR=.build
PWD=$( pwd )
TARGET_NAME=run-workspace

export TARGET_NAME

if [ ! -d ${BUILD_DIR} ];
then
    mkdir --parents    \
          ${BUILD_DIR}

    cd ${BUILD_DIR}

    cmake ../src -DCMAKE_BUILD_TYPE=Debug
else
    cd ${BUILD_DIR}
fi

echo ""

make ${TARGET_NAME}

echo ""

./${TARGET_NAME}

cd ${PWD}

#!/bin/bash

set -euo pipefail

source /etc/talsen/util/indicator/workspace-gunit-lib-indicator.bash
source /etc/talsen/util/indicator/workspace-meson-options-indicator.bash
WORKSPACE_CPP_FLAGS_DEFAULT_INDICATOR=.workspace/.cpp-flags.default

BUILD_DIR=.build
PWD=$( pwd )
TARGET_NAME=run-workspace

if [ ! -d ${BUILD_DIR} ];
then
    CPP_FLAGS_DEFAULT=""
    for FLAG in $( cat ${WORKSPACE_CPP_FLAGS_DEFAULT_INDICATOR} )
    do
        CPP_FLAGS_DEFAULT="'${FLAG}', ${CPP_FLAGS_DEFAULT}"
    done
    CPP_FLAGS_DEFAULT="${CPP_FLAGS_DEFAULT::-2}"

    SOURCES=""
    for SOURCE in $( find . -name *.cpp -printf '%P ' | xargs echo )
    do
        SOURCES="'${SOURCE}', ${SOURCES}"
    done
    SOURCES="${SOURCES::-2}"

    cat ${WORKSPACE_MESON_OPTIONS_INDICATOR} \
    > meson_options.txt
    echo "option( 'exe_name', type : 'string', value : '${TARGET_NAME}' )" \
    >> meson_options.txt
    echo "option( 'gunit_lib_dir', type : 'string', value : '$( pwd )/${WORKSPACE_GUNIT_LIB_INDICATOR}' )" \
    >> meson_options.txt
    echo "option( 'sources', type : 'array', value : [ ${SOURCES} ] )" \
    >> meson_options.txt
    echo "option( 'x_cpp_flags_default', type : 'array', value : [ ${CPP_FLAGS_DEFAULT} ] )" \
    >> meson_options.txt

    meson ${BUILD_DIR}
fi

cd ${BUILD_DIR}

echo ""

ninja

echo ""

./${TARGET_NAME}

cd ${PWD}

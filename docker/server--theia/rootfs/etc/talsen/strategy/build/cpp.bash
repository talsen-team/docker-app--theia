#!/bin/bash

set -euo pipefail

source /etc/talsen/util/indicator/workspace-build-focus-indicator.bash
source /etc/talsen/util/indicator/workspace-gunit-lib-indicator.bash
source /etc/talsen/util/indicator/workspace-meson-options-indicator.bash
source /etc/talsen/util/indicator/workspace-cpp-flags-default-indicator.bash

BUILD_DIR=.build
BUILD_FOCUS=$( cat ${WORKSPACE_BUILD_FOCUS_INDICATOR} )
PWD=$( pwd )
TARGET_NAME=run-workspace

source /etc/talsen/util/indicator/workspace-cpp-flags-${BUILD_FOCUS}-indicator.bash

if [ ! -d ${BUILD_DIR} ];
then
    CPP_FLAGS_DEFAULT=""
    for FLAG in $( cat ${WORKSPACE_CPP_FLAGS_DEFAULT_INDICATOR} )
    do
        CPP_FLAGS_DEFAULT="'${FLAG}', ${CPP_FLAGS_DEFAULT}"
    done
    if (( ${#CPP_FLAGS_DEFAULT} > 1 ));
    then
        CPP_FLAGS_DEFAULT="${CPP_FLAGS_DEFAULT::-2}"
    fi

    CPP_FLAGS_FOCUS=""
    for FLAG in $( cat ${WORKSPACE_CPP_FLAGS_FOCUS_INDICATOR} )
    do
        CPP_FLAGS_FOCUS="'${FLAG}', ${CPP_FLAGS_FOCUS}"
    done
    if (( ${#CPP_FLAGS_FOCUS} > 1 ));
    then
        CPP_FLAGS_FOCUS="${CPP_FLAGS_FOCUS::-2}"
    fi

    SOURCES=""
    for SOURCE in $( find . -name *.cpp -printf '%P ' | xargs echo )
    do
        SOURCES="'${SOURCE}', ${SOURCES}"
    done
    if (( ${#SOURCES} > 1 ));
    then
        SOURCES="${SOURCES::-2}"
    fi

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
    echo "option( 'x_cpp_flags_focus', type : 'array', value : [ ${CPP_FLAGS_FOCUS} ] )" \
    >> meson_options.txt

    meson ${BUILD_DIR}
fi

cd ${BUILD_DIR}

echo ""

ninja

echo ""

./${TARGET_NAME}

cd ${PWD}

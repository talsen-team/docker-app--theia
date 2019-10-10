#!/bin/bash

set -euo pipefail

BUILD_DIR=.build
PWD=$( pwd )

if [ ! -d ${BUILD_DIR} ];
then
    echo "option( 'gunit_lib_dir', type : 'string', value : '$( pwd )/.workspace/.gunit/lib' )" > meson_options.txt
    echo "option( 'gunit_include_dir', type : 'string', value : '.workspace/.gunit/lib/include' )" >> meson_options.txt

    meson ${BUILD_DIR}
fi

cd ${BUILD_DIR}

echo ""

ninja

echo ""

ninja test

cd ${PWD}

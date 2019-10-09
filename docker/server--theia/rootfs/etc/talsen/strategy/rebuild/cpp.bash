#!/bin/bash

set -euo pipefail

BUILD_DIR=.build

rm --force --recursive \
   ${BUILD_DIR}

source /etc/talsen/strategy/build/cpp.bash

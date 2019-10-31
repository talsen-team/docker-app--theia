#!/bin/bash

set -euo pipefail

HOME_DIR=/home/theia
PROJECT_DIR=/home/project
PLUGINS_DIR=/home/theia/plugins

sudo chown --recursive \
           theia:theia \
           ${HOME_DIR}

sudo chown --recursive    \
           theia:theia    \
           ${PROJECT_DIR}

yarn theia start ${PROJECT_DIR}                     \
                 --hostname=0.0.0.0                 \
                 --plugins=local-dir:${PLUGINS_DIR}

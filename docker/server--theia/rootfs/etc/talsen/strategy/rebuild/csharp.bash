#!/bin/bash

set -euo pipefail

rm --force --recursive \
   src/{bin,obj}

source /etc/talsen/strategy/build/csharp.bash

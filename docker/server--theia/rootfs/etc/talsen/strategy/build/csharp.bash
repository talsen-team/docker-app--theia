#!/bin/bash

set -euo pipefail

if [ ! -f *.sln ];
then
    echo "Cannot build, there is no solution to build ..."
    exit 1
fi

set +e

mkdir --parents \
      .build

dotnet test /p:CollectCoverage=true &> .build/.test-output

cat .build/.test-output

set -e

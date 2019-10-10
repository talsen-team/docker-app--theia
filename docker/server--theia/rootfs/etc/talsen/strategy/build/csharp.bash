#!/bin/bash

set -euo pipefail

if [ ! -f *.sln ];
then
    echo "Cannot build, there is no solution to build ..."
    exit 1
fi

set +e

dotnet test /p:CollectCoverage=true &> .test-output

cat .test-output

set -e

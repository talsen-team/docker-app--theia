#!/bin/bash

set -euo pipefail

BUILD_DIR=.build
TEMP_COVERAGE_FILE=${BUILD_DIR}/meson-logs/coverage-temp.info
TEMP_COVERAGE_DIR=${BUILD_DIR}/meson-logs/coveragereport

echo -e "Generating coverage report ..."

lcov --directory ${BUILD_DIR}            \
     --capture                           \
     --output-file ${TEMP_COVERAGE_FILE} \
     --rc lcov_branch_coverage=1         \
     --no-checksum

echo ""

genhtml --prefix ${BUILD_DIR}                   \
        --output-directory ${TEMP_COVERAGE_DIR} \
        --title 'Code coverage'                 \
        --legend                                \
        --branch-coverage                       \
        --show-details ${TEMP_COVERAGE_FILE}

echo -e "Generating coverage report ... done"

#!/bin/bash

set -euo pipefail

GLOBIGNORE="*" # prevent expansion of wildcards link '/usr/include/*' or similar

BUILD_DIR=.build
COVERAGE_DIR=.coverage
COVERAGE_FILE=${BUILD_DIR}/meson-logs/coverage.info
TEMP_COVERAGE_DIR=${BUILD_DIR}/meson-logs/coveragereport
TEMP_COVERAGE_FILE=${BUILD_DIR}/meson-logs/coverage-temp.info

echo -e "Generating coverage report ..."

LCOV_EXLCUDE=""
while IFS= read -r ITEM
do
    LCOV_EXLCUDE="${LCOV_EXLCUDE}'${ITEM}' "
done < .lcovignore

lcov --directory ${BUILD_DIR}            \
     --capture                           \
     --output-file ${TEMP_COVERAGE_FILE} \
     --rc lcov_branch_coverage=1         \
     --no-checksum

echo ""

lcov --remove ${TEMP_COVERAGE_FILE}      \
     $( eval echo -e "${LCOV_EXLCUDE}" ) \
     --output-file ${COVERAGE_FILE}      \
     --rc lcov_branch_coverage=1

echo ""

genhtml --prefix ${BUILD_DIR}                   \
        --output-directory ${TEMP_COVERAGE_DIR} \
        --title 'Code coverage'                 \
        --legend                                \
        --branch-coverage                       \
        --show-details ${COVERAGE_FILE}

rsync --archive             \
      ${TEMP_COVERAGE_DIR}/ \
      ${COVERAGE_DIR}

echo -e "Generating coverage report ... done"

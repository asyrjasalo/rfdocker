#!/usr/bin/env bash

set -e
set -u

### globals ####################################################################

this_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
temp_results_path="/tmp/rfdocker-tests"

### main #######################################################################

mkdir -p "$temp_results_path"

export RESULTS_PATH="$temp_results_path"
echo -e "[rfdocker] Using a temporary RESULTS_PATH for tests: $RESULTS_PATH\n"

TESTS_PATH="$this_path/../tests" "$this_path/../bin/rfdocker" tests

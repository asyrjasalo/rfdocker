#!/usr/bin/env bash

set -e
set -u

### globals ####################################################################

this_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export RESULTS_PATH="$(mktemp -d -t rfdocker-tests-XXXXXX)"
echo -e "[rfdocker] Using a temporary RESULTS_PATH for tests: $RESULTS_PATH\n"

TESTS_PATH=../tests "$this_path/../bin/rfdocker" tests

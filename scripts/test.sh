#!/usr/bin/env bash

set -e
set -u

### globals ####################################################################

this_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
temp_results_path="/tmp/rfdocker-tests"
release_name=$(cat "$this_path/../release_name")

### main #######################################################################

mkdir -p "$temp_results_path"

docker run --rm -ti \
  -e UID=$(id -u) \
  -e GID=$(id -g) \
  -v "$temp_results_path":/home/robot/results \
  -v "$this_path/../tests":/home/robot/tests \
    "rfdocker:$release_name" \
    tests

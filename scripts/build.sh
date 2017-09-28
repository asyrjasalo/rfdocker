#!/usr/bin/env bash

set -e

### globals ####################################################################

this_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
rf_version=$(cat "$this_path/../rf_version")

### main #######################################################################

docker build --rm \
  --build-arg RF_VERSION="$rf_version" \
  -t "rfdocker:$rf_version" \
  "$this_path/../docker"

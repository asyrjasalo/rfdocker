#!/usr/bin/env bash

set -e

### globals ####################################################################

this_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
release_name=$(cat "$this_path/../release_name")

### main #######################################################################

docker build --rm \
  --build-arg RF_VERSION="$(echo $release_name | cut -d '-' -f 1)" \
  -t "rfdocker:$release_name" \
  "$this_path/../docker"

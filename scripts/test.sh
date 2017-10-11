#!/usr/bin/env bash

set -e

### globals ####################################################################

this_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
release_name="$(cat "$this_path/../release_name")"

### main #######################################################################

docker run --rm -ti -e HOST_UID=$UID -e HOST_GID=$GID \
  -v "$this_path/..":/home/robot \
  "rfdocker:$release_name" tests/

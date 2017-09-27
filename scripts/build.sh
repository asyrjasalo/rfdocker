#!/usr/bin/env bash

set -e

### globals ####################################################################

this_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

### main #######################################################################

docker build -t rfdocker:"${1:-latest}" "$this_path/../docker"

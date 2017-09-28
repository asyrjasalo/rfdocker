#!/usr/bin/env bash

set -e

### globals ####################################################################

this_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
rf_version=$(cat "$this_path/../rf_version")

### main #######################################################################

git tag --force --annotate \
  --message "Release $rf_version" \
  "$rf_version"

echo "### Pushing image 'rfdocker:$rf_version' to registry..."
docker push "rfdocker:$rf_version"

#!/usr/bin/env bash

set -e

### globals ####################################################################

this_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
rf_version=$(cat "$this_path/../rf_version")

### main #######################################################################

if [ -z "$1" ]; then
  echo "Usage: $0 REPOSITORY_URL"
  echo ""
  echo "  e.g.: $0 https://your.registry.com:5000/rfdocker"
  exit 64
fi

echo "### Creating a git tag '$rf_version' for the release"
git tag --force --annotate --message "Release $rf_version" "$rf_version"

repository_url="$1"

echo "### Tagging image 'rfdocker:$rf_version' to '$repository_url:$rf_version'"
docker tag "rfdocker:$rf_version" "$repository_url:$rf_version"

echo "### Pushing image 'rfdocker:$rf_version' to registry..."
docker push "$repository_url:$rf_version"

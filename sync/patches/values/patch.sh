#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) ; readonly SCRIPT_DIR
source "${SCRIPT_DIR}"/../../_helpers.sh

# we need to set the tag field in values.yaml to match the version being
# synced from upstream.

# get the upstream sync version from vendir.yml
UPSTREAM_SYNC_VERSION=$(yq -r .directories[0].contents[0].githubRelease.tag "${REPO_DIR}"/vendir.yml)

# copy over values file
cp "${SCRIPT_DIR}"/manifests/values.yaml "${VALUES_YAML}"

# set the image tag in values.yaml
sed -i -E "s/tag.*$/tag: ${UPSTREAM_SYNC_VERSION}/" "${VALUES_YAML}"

# Generate schema.
echo "Generating values schema..."
if ! helm plugin list | grep -q values-schema-json; then
  helm plugin install https://github.com/losisin/helm-values-schema-json.git --verify=false || true
fi
helm schema -f "${VALUES_YAML}" -o "${CHART_DIR}"/values.schema.json

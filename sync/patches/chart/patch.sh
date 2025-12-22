#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

repo_dir=$(git rev-parse --show-toplevel) ; readonly repo_dir
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) ; readonly script_dir
CHART_DIR="${repo_dir}/helm/cluster-api-control-plane-provider-kamaji" ; readonly CHART_DIR

cd "${script_dir}"

# we need to get the current version of the chart in order to
# reset it after copying Chart.yaml over.
CHART_VERSION=$(yq -r '.version' "${CHART_DIR}/Chart.yaml") ; readonly CHART_VERSION

# we need to set the appVersion field in Chart.yaml to match the
# version being synced from upstream.

# get the upstream sync version from vendir.yml
UPSTREAM_SYNC_VERSION=$(yq -r .directories[0].contents[0].githubRelease.tag ${repo_dir}/vendir.yml)
# strip leading 'v' if present
UPSTREAM_SYNC_VERSION_STRIPPED="${UPSTREAM_SYNC_VERSION#v}"

cp manifests/Chart.yaml "${CHART_DIR}"/Chart.yaml

# set the app version in Chart.yaml
sed -i -E "s/^appVersion.*$/appVersion: ${UPSTREAM_SYNC_VERSION_STRIPPED}/" "${CHART_DIR}/Chart.yaml"

# reset the version in Chart.yaml
sed -i -E "s/^version.*$/version: ${CHART_VERSION}/" "${CHART_DIR}/Chart.yaml"

# copy over values file and schema
cp manifests/values.yaml "${CHART_DIR}"/values.yaml
cp manifests/values.schema.json "${CHART_DIR}"/values.schema.json

# set the image tag  in values.yaml
sed -i -E "s/tag.*$/tag: ${UPSTREAM_SYNC_VERSION}/" "${CHART_DIR}/values.yaml"

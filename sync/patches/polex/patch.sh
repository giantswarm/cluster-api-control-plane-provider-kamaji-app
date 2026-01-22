#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

repo_dir=$(git rev-parse --show-toplevel) ; readonly repo_dir
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) ; readonly script_dir
CHART_DIR="${repo_dir}/helm/cluster-api-control-plane-provider-kamaji" ; readonly CHART_DIR

cd "${script_dir}"

echo "Adding policy-exception"

set -x

cp -r manifests/policy-exception.yaml "${CHART_DIR}"/templates/policy-exception.yaml

{ set +x; } 2>/dev/null

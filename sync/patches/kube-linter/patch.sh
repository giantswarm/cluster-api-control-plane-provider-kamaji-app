#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

repo_dir=$(git rev-parse --show-toplevel) ; readonly repo_dir
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) ; readonly script_dir
CHART_DIR="${repo_dir}/helm/cluster-api-control-plane-provider-kamaji" ; readonly CHART_DIR

cd "${repo_dir}"

echo "Syncing kube-linter config"

cp -r "${script_dir}"/manifests/kube-linter.yaml "${CHART_DIR}"/.kube-linter.yaml

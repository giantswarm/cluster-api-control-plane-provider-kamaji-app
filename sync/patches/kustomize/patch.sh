#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

repo_dir=$(git rev-parse --show-toplevel) ; readonly repo_dir
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) ; readonly script_dir
VENDIR_DIR="${repo_dir}/vendor/kamaji" ; readonly VENDIR_DIR
CHART_DIR="${repo_dir}/helm/cluster-api-control-plane-provider-kamaji" ; readonly CHART_DIR

cd "${script_dir}"

rm -rf "${script_dir}"/tmp/
mkdir -p "${script_dir}"/tmp/{input,output}

cp "${VENDIR_DIR}"/control-plane-components.yaml "${script_dir}"/tmp/input/

kustomize build "${script_dir}" -o "${script_dir}"/tmp/output/

cp "${script_dir}"/tmp/output/*.yaml "${CHART_DIR}"/templates/

rm -rf "${script_dir}"/tmp/

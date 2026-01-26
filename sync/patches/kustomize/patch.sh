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

# process deployment file to remove bash variable substitutions
DEPLOYMENT_FILE=$(find "${script_dir}"/tmp/output/ -iname \*deployment\*)

if [ -z "${DEPLOYMENT_FILE}" ]; then
    echo "Could not find deployment file in the kustomize output."
    exit 1
fi

sed -i -E 's/\$\{[^:]+:=([^}]+)\}/\1/g' "${DEPLOYMENT_FILE}"
# finished processing deployment file

cp "${script_dir}"/tmp/output/*.yaml "${CHART_DIR}"/templates/

rm -rf "${script_dir}"/tmp/

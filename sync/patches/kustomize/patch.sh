#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) ; readonly SCRIPT_DIR
source "${SCRIPT_DIR}"/../../_helpers.sh

rm -rf "${SCRIPT_DIR}"/tmp/
mkdir -p "${SCRIPT_DIR}"/tmp/{input,output}

cp "${VENDIR_SYNC_DIR}"/control-plane-components.yaml "${SCRIPT_DIR}"/tmp/input/

kustomize build "${SCRIPT_DIR}" -o "${SCRIPT_DIR}"/tmp/output/

# process deployment file to remove bash variable substitutions
DEPLOYMENT_FILE=$(find "${SCRIPT_DIR}"/tmp/output/ -iname \*deployment\*)

if [ -z "${DEPLOYMENT_FILE}" ]; then
    echo "Could not find deployment file in the kustomize output."
    exit 1
fi

sed -i -E 's/\$\{[^:]+:=([^}]+)\}/\1/g' "${DEPLOYMENT_FILE}"
# finished processing deployment file

cp "${SCRIPT_DIR}"/tmp/output/*.yaml "${CHART_DIR}"/templates/
rm -rf "${SCRIPT_DIR}"/tmp/

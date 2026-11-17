#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) ; readonly SCRIPT_DIR
source "${SCRIPT_DIR}"/../../_helpers.sh

echo "Adding policy-exception"

set -x
cp -r "${SCRIPT_DIR}"/manifests/policy-exception.yaml "${CHART_DIR}"/templates/policy-exception.yaml
cp -r "${SCRIPT_DIR}"/manifests/policy-exception-cel.yaml "${CHART_DIR}"/templates/policy-exception-cel.yaml
{ set +x; } 2>/dev/null

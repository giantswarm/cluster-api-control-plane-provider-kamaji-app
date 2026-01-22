#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) ; readonly dir
cd "${dir}/.."

set -x
# Sync using vendir
vendir sync
{ set +x; } 2>/dev/null

# test if requirements are installed
PROGRAMS=("yq" "kustomize")
for program in "${PROGRAMS[@]}"; do
    if ! command -v "${program}" &> /dev/null; then
        echo "${program} not installed; aborting."
        exit 1
    fi
done

# patches
# add/remove/patch various components in the upstream manifest
./sync/patches/kustomize/patch.sh
# add a polex manually (cannot be created with kustomize)
./sync/patches/polex/patch.sh
# set up the chart dir
./sync/patches/chart/patch.sh
# copy of values files
./sync/patches/values/patch.sh
# keep the linters happy
./sync/patches/kube-linter/patch.sh

if ! git diff --quiet --exit-code helm/ ; then
    echo -e "\n---------- PRINTING GIT DIFF ----------\n"
    git diff helm/
fi

# file has no shebang so shellcheck needs to be told
# shellcheck shell=bash
# stop shellcheck complaining about unused variables
# shellcheck disable=SC2034

# root dir of the git repository
REPO_DIR=$(git rev-parse --show-toplevel) ; readonly REPO_DIR

SCRIPT_DIR_REL=".${SCRIPT_DIR#"${REPO_DIR}"}" ; readonly SCRIPT_DIR

# root dir of the generated helm chart
CHART_DIR="${REPO_DIR}/helm/cluster-api-control-plane-provider-kamaji" ; readonly CHART_DIR

# root dir of the vendir synced chart
VENDIR_SYNC_DIR="${REPO_DIR}/vendor/kamaji" ; readonly VENDIR_SYNC_DIR

# values.yaml in chart dir
VALUES_YAML="${CHART_DIR}"/values.yaml ; readonly VALUES_YAML

# used by sync/changelog.sh to add the upstream chart name to the changelog entry.
UPSTREAM_NAME="cluster-api-control-plane-provider-kamaji" ; readonly UPSTREAM_NAME

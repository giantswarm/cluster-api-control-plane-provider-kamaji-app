# Keeping the chart up to date and preserving GS specific configuration

The `sync.sh` script is used to keep the chart up to date with the upstream repository and to add Giant Swarm specific changes.
We use `vendir` to manage the chart dependencies and `git patch` to apply the Giant Swarm specific changes. We also use `cp` to copy over specific files which are not present in the upstream manifests.

As the upstream chart publishes the manifests as a single file (and not a Helm chart), the update process is a little different from our other charts. To split the manifest into individual templates (as per Helm best practises), we use Kustomize. Kustomize is also used to patch the manifests.

## How to sync the chart with upstream

The `vendir.yml` configuration points to a specific version of the upstream manifests.
Running `vendir sync` will fetch the control plane components manifest from the upstream repository and make it available for applying our changes to.

1. Update the upstream version in the `vendir.yml` file.
2. Run `vendir sync`

## How to maintain Giant Swarm specific changes to upstream manifests

This folder contains the `sync.sh` script which does the following:

- Retrieves the upstream manifest (see above).
- Applies all patches in the `patches` directory to the manifests.
- Copies the resulting manifests to the `helm` directory.

Generally running the script should be enough to keep the chart up to date with the upstream manifest and to preserve Giant Swarm specific changes. Renovate is also configured to automatically open PRs against `vendir.yml` when a new upstream version is available.

1. Update the chart version in the `vendir.yml` file.
2. Run `./sync.sh`

However, if the upstream manifest changes in a way that conflicts with a patch, it might have to be regenerated.

## How to generate a patch

Patches are simply git diffs of the changes made to the upstream manifest.

1. Run `vendir sync` to get the latest upstream manifest.
2. Commit only the manifest that you want to generate a patch for.
3. Make the Giant Swarm specific changes to the manifest.
4. Run `git diff helm/cluster-api-control-plane-provider-kamaji/PATH/TO/FILE > sync/patches/PATCH_NAME/_FILE_NAME.patch`
5. Run `./sync.sh` to apply all patches.

## Current patches

### Chart

Location: `sync/patches/chart/`

- Adds Giant Swarm specific annotations to the chart metadata:
  - `io.giantswarm.application.audience`: Indicates whether the app is installed by Giant Swarm or customers
  - `io.giantswarm.application.managed`: Indicates whether the app is managed by Giant Swarm
  - `io.giantswarm.application.team`: Identifies the team responsible for maintaining this app
  - `io.giantswarm.application.upstream`: Points to the upstream repository
  - `io.giantswarm.application.upstream-chart-version`: Indicates the upstream chart version
- Replaces the `APP_VERSION_PLACEHOLDER` with the upstream release version being synced by vendir.
- Replaces the `VERSION_PLACEHOLDER` with the latest released version of the chart.

### Kube Linter

Location: `sync/patches/kube-linter/`

- Adds kube-linter config file to the chart to disable certain checks.

### Kustomize

Location: `sync/patches/kustomize/`

- Splits the upstream multi-document manifest into individual files for each resource.
- Makes the `namespace` value configurable for all resources to enable Helm templating.
- Deletes the `Namespace` resource as it is not needed in the Helm chart.
- Patches the `Deployment` resource to allow configuration by Helm values.
- Adds additional labels to all resources.
- Adds a `CiliumNetworkPolicy` resource to allow communication between Kamaji components.

### Values

Location: `sync/patches/values/`

- Copies over `values.yaml` and `values.schema.json` to the chart.

## Adding new patches

To add a new patch for a different file:

1. Create a new directory under `sync/patches/` (e.g., `sync/patches/myfile/`)
2. Create the patch file with the naming convention `_filename.patch`
3. Create a `patch.sh` script following the pattern in other patch directories
4. Make the script executable: `chmod +x sync/patches/myfile/patch.sh`
5. Add the patch script to the `sync.sh` main script

## Troubleshooting

### Patch fails to apply

If a patch fails to apply after syncing with a new upstream version:

1. Check what changed in the upstream file
2. Follow the steps in "How to generate a patch"

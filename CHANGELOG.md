# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Update app icon to the v2 Giant Swarm kamaji icon.

## [0.4.2] - 2026-01-27

### Changed

- Raise pod memory limit from 128MB to 256MB.

### Fixed

- Fix pod selector in `ciliumNetworkPolicy`.

## [0.4.1] - 2026-01-27

### Fixed

- Fix Deployment manifest to remove erroneous variable substitutions.

## [0.4.0] - 2026-01-22

### Added

- Added PolicyException.

## [0.3.2] - 2026-01-22

### Fixed

- Fix quoting team annotation value.

## [0.3.1] - 2026-01-22

### Fixed

- Fix team annotation lookup key.

## [0.3.0] - 2026-01-22

### Changed

- Push chart to control-plane-catalog.

## [0.2.1] - 2026-01-20

### Fixed

- Correct app name in circleci config.

## [0.2.0] - 2026-01-16

### Added

- Add GitHub actions workflow to run `sync.sh` on PRs.
- Add additional metadata to `Chart.yaml`.
- Add README to sync dir.

### Changed

- Separate values patching into its own patch directory.
- Ensure team annotation is applied to all resources.

## [0.1.1] - 2026-01-08

### Fixed

- Remove unused labels which caused linting to fail.
- Configure linters to pass CI checks.

## [0.1.0] - 2026-01-08

### Changed

- Push to `kamaji-addons-app-collection`.

### Added

- Add initial chart at upstream v0.16.0

[Unreleased]: https://github.com/giantswarm/cluster-api-control-plane-provider-kamaji-app/compare/v0.4.2...HEAD
[0.4.2]: https://github.com/giantswarm/cluster-api-control-plane-provider-kamaji-app/compare/v0.4.1...v0.4.2
[0.4.1]: https://github.com/giantswarm/cluster-api-control-plane-provider-kamaji-app/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/giantswarm/cluster-api-control-plane-provider-kamaji-app/compare/v0.3.2...v0.4.0
[0.3.2]: https://github.com/giantswarm/cluster-api-control-plane-provider-kamaji-app/compare/v0.3.1...v0.3.2
[0.3.1]: https://github.com/giantswarm/cluster-api-control-plane-provider-kamaji-app/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/giantswarm/cluster-api-control-plane-provider-kamaji-app/compare/v0.2.1...v0.3.0
[0.2.1]: https://github.com/giantswarm/cluster-api-control-plane-provider-kamaji-app/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/giantswarm/cluster-api-control-plane-provider-kamaji-app/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/giantswarm/cluster-api-control-plane-provider-kamaji-app/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/giantswarm/cluster-api-control-plane-provider-kamaji-app/releases/tag/v0.1.0

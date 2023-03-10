# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## [1.1.2] - 2023-03-10
### Changed
- Do not pass internal inputs to the docker run step

## [1.1.1] - 2023-03-05
### Added
- Added `ref` input to accept the GitHub repository ref
- Added `image` input to specify the docker image name (defaults to repository)

### Changed
- `tag` is no longer required, defaults to `ref` which is now the required input

## [1.1.0] - 2023-03-05
### Changed
- Updated the output of the action to include all the outputs of the docker run step in JSON format, using the `toJSON` function. Removed the previous output file.

## [1.0.0] - 2023-03-04
### Added
- v1 of the Docker container action

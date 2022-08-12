# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

[Unreleased]: https://github.com/envato/stack_master-http_parameter_resolver/compare/v0.3.0...HEAD

## [0.3.0] - 2022-08-12

### Changed

- Default git branch renamed to `main`.
- CI build runs on GitHub Actions ([#3]).
- CI runs test suite on Ruby 3.0 and 3.1 ([#4]).
- Loosen faraday dependency constraint: allow version 1 and 2 ([#5]).

[0.3.0]: https://github.com/envato/stack_master-http_parameter_resolver/compare/v0.2.0...v0.3.0
[#3]: https://github.com/envato/stack_master-http_parameter_resolver/pull/3
[#4]: https://github.com/envato/stack_master-http_parameter_resolver/pull/4
[#5]: https://github.com/envato/stack_master-http_parameter_resolver/pull/5

## [0.2.0] - 2020-05-25

### Changed

- Introduce strategies for parsing the HTTP response ([#2]). This changes how
  to configure the parameter resolver. eg.

  ```diff
   cloudflare_cidr_ips:
  -  http: https://www.cloudflare.com/ips-v4
  +  http:
  +    url: https://www.cloudflare.com/ips-v4
  +    strategy: one_per_line
  ```

[0.2.0]: https://github.com/envato/stack_master-http_parameter_resolver/compare/v0.1.0...v0.2.0
[#2]: https://github.com/envato/stack_master-http_parameter_resolver/pull/2

## [0.1.0] - 2020-01-14

### Added

- Initial functionality: Obtaining parameters from HTTP calls returning plain
  text, ([#1]).

[0.1.0]: https://github.com/envato/stack_master-http_parameter_resolver/tree/v0.1.0
[#1]: https://github.com/envato/stack_master-http_parameter_resolver/pull/1

# StackMaster::HttpParameterResolver

[![License MIT](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://github.com/envato/stack_master-http_parameter_resolver/blob/main/LICENSE.txt)
[![Gem Version](https://badge.fury.io/rb/stack_master-http_parameter_resolver.svg)](https://rubygems.org/gems/stack_master-http_parameter_resolver)
[![Build Status](https://github.com/envato/stack_master-http_parameter_resolver/workflows/tests/badge.svg?branch=main)](https://github.com/envato/stack_master-http_parameter_resolver/actions?query=branch%3Amain+workflow%3Atests)

A [StackMaster] parameter resolver that obtains values via HTTP calls.

[StackMaster]: https://github.com/envato/stack_master

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stack_master-http_parameter_resolver'
```

And then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install stack_master-http_parameter_resolver
```

## Usage

For example, to resolve the Cloudflare IPv4 ranges:

```yaml
cloudflare_ips:
  http:
    url: https://www.cloudflare.com/ips-v4
    strategy: one_per_line
```

To obtain both the Cloudlare IPv4 and IPv6 ranges:

```yaml
cloudflare_ips:
  - http:
      url: https://www.cloudflare.com/ips-v4
      strategy: one_per_line
  - http:
      url: https://www.cloudflare.com/ips-v6
      strategy: one_per_line
```

## Development

After checking out the repo, run `script/setup` to install dependencies. You can also run `script/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/envato/stack_master-http_parameter_resolver.

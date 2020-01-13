# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stack_master/http_parameter_resolver/version'

Gem::Specification.new do |spec|
  spec.name     = 'stack_master-http_parameter_resolver'
  spec.version  = StackMaster::HttpParameterResolver::VERSION
  spec.authors  = ['Envato']
  spec.email    = ['rubygems@envato.com']
  spec.licenses = ['MIT']
  spec.summary  = 'Obtain stack parameters from HTTP calls.'
  spec.homepage = "https://github.com/envato/#{spec.name}"

  spec.metadata = {
    'homepage_uri'      => spec.homepage,
    'bug_tracker_uri'   => "#{spec.homepage}/issues",
    'changelog_uri'     => "#{spec.homepage}/blob/master/CHANGELOG.md",
    'documentation_uri' => "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}",
    'source_code_uri'   => "#{spec.homepage}/tree/v#{spec.version}",
  }

  spec.require_paths = ['lib']
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").select do |file|
      file.match(%r{^(lib/|CHANGELOG|LICENSE|README)})
    end
  end

  spec.required_ruby_version = ">= 2.4.0"

  spec.add_dependency 'faraday', '~> 1'
  spec.add_dependency 'stack_master'
  spec.add_development_dependency 'bundler', '~> 2'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3'
end

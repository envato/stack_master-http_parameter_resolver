# frozen_string_literal: true

require 'faraday'

module StackMaster
  module ParameterResolvers
    class Http < Resolver
      NotResolved = Class.new(StandardError)

      array_resolver

      def initialize(_config, _stack_definition); end

      def resolve(url)
        response = connection(url).get
        response.body.split(/\s+/)
      rescue Faraday::Error
        raise NotResolved, "Unable to resolve HTTP parameters from #{url}"
      end

      private

      def connection(url)
        Faraday.new(
          url: url,
          params: {},
          headers: { 'Accept' => 'text/plain' }
        ) do |connection|
          connection.response :raise_error
          connection.adapter :net_http
        end
      end
    end
  end
end

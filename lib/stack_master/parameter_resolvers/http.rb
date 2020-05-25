# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'
require 'faraday'

Dir[File.join(__dir__, '..', 'http_parameter_resolver', 'strategy', '**', '*.rb')]
  .sort.each { |file| require file }

module StackMaster
  module ParameterResolvers
    class Http < Resolver
      NotResolved = Class.new(StandardError)
      Misconfigured = Class.new(StandardError)

      array_resolver

      def initialize(_config, _stack_definition); end

      def resolve(args)
        usage unless args.is_a? Hash
        url = args.fetch('url') { usage("'url' not provided") }
        strategy = build_strategy(args.fetch('strategy') { usage("'strategy' not provided") })
        http(url, strategy)
      rescue Faraday::Error
        raise NotResolved, "Unable to resolve HTTP parameters from #{url}"
      end

      private

      def usage(message = 'Misconfigured HTTP parameter resolver')
        raise Misconfigured, <<~MESSAGE
          #{message}

          Please configure according to the following pattern:

          <my-parameter-name>:
            http:
              url: <my-http-url>
              strategy: <response-parsing-strategy>

          Where <response-parsing-strategy> is one of the supported strategies:
          - one_per_line
        MESSAGE
      end

      def build_strategy(strategy)
        class_name = "StackMaster::HttpParameterResolver::Strategy::"\
                     "#{strategy.classify}"
        class_name.constantize.new
      rescue NameError
        usage("The strategy #{strategy.inspect} is not supported")
      end

      def http(url, strategy)
        response = connection(url, strategy).get
        strategy.parse(response)
      end

      def connection(url, strategy)
        Faraday.new(
          url: url,
          params: {},
          headers: { 'Accept' => strategy.accept }
        ) do |connection|
          connection.response :raise_error
          connection.adapter :net_http
        end
      end
    end
  end
end

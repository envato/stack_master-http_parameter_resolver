# frozen_string_literal: true

module StackMaster
  module HttpParameterResolver
    module Strategy
      class OnePerLine
        def accept
          'text/plain'
        end

        def parse(response)
          response.body.split(/[\r\n]+/)
        end
      end
    end
  end
end

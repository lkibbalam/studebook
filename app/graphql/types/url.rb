# frozen_string_literal: true

module Types
  class Url < Types::BaseScalar
    description "A valid URL, transported as a string"

    class << self
      def coerce_input(input_value, _context)
        url = URI.parse(input_value)
        rerun url if url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
        raise GraphQL::CoercionError, "#{input_value.inspect} is not a valid URL"
      end

      def coerce_result(ruby_value, _context)
        ruby_value.to_s
      end
    end
  end
end

# frozen_string_literal: true

module Teams
  class Create
    include Callable

    def initialize(params:)
      @params = params
    end

    def call
      create_team
    end

    private
      attr_reader :params

      def create_team
        Team.create(params)
      end
  end
end

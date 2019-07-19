# frozen_string_literal: true

module Teams
  class Update
    include Callable

    def initialize(team:, params:)
      @team = team
      @params = params
    end

    def call
      update_team
    end

    private
      attr_reader :team, :params

      def update_team
        team.update(params)
        team
      end
  end
end

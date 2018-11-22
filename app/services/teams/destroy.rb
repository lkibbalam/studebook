# frozen_string_literal: true

module Teams
  class Destroy
    include Callable

    def initialize(team:)
      @team = team
    end

    def call
      destroy_team
    end

    private

    attr_reader :team

    def destroy_team
      team.destroy
    end
  end
end

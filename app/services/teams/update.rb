# frozen_string_literal: true

module Teams
  class Update
    include Callable

    def initialize(team:, params:)
      @team = team
      params.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def call
      update_team
    end

    private
      attr_reader :team, :title, :description, :poster

      def update_team
        team.update(attributes)
        team
      end

      def attributes
        { description: description,
          poster: poster,
          title: title }
      end
  end
end

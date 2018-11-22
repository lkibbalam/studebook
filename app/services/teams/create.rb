# frozen_string_literal: true

module Teams
  class Create
    include Callable

    def initialize(params:)
      params.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def call
      create_team
    end

    private

    attr_reader :title, :description, :poster

    def create_team
      Team.create(attributes)
    end

    def attributes
      { title: title,
        description: description,
        poster: poster }.compact
    end
  end
end

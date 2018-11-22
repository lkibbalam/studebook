# frozen_string_literal: true

require 'rails_helper'

module Courses
  class Create
    include Callable

    def initialize(params:)
      params.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def call
      create_course
    end

    private

    attr_reader :title, :description, :poster, :author_id, :team_id

    def create_course
      Course.create(attributes)
    end

    def attributes
      { title: title,
        description: description,
        poster: poster,
        author_id: author_id,
        team_id: team_id }.compact
    end
  end
end

# frozen_string_literal: true

module Courses
  class Update
    include Callable

    def initialize(course:, params:)
      @course = course
      params.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def call
      update_course
    end

    private

    attr_reader :course, :title, :description, :poster, :team_id

    def update_course
      course.update(attributes)
      course
    end

    def attributes
      { description: description,
        team_id: team_id,
        poster: poster,
        title: title }.compact
    end
  end
end

# frozen_string_literal: true

module Courses
  class UpdateCourse
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
      course.update(course_params)
      course
    end

    def course_params
      { title: title, description: description,
        poster: poster, team_id: team_id }.compact
    end
  end
end

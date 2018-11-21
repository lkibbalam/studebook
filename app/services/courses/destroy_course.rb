# frozen_string_literal: true

module Courses
  class DestroyCourse
    include Callable

    def initialize(course:)
      @course = course
    end

    def call
      destroy_course
    end

    private

    attr_reader :course

    def destroy_course
      course.destroy
    end
  end
end

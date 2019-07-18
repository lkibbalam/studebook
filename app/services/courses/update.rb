# frozen_string_literal: true

module Courses
  class Update
    include Callable

    def initialize(course:, params:)
      @course = course
      @params = params
    end

    def call
      update_course
    end

    private
      attr_reader :course, :params

      def update_course
        course.update(params)
        course
      end
  end
end

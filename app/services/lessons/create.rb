module Lessons
  class Create
    include Callable

    def inizialize(course:, params:)
      @course = course
      @params = params
    end

    def call
      create_lesson
    end

    private
      attr_reader :course, :params

      def create_lesson
        course.lessons.create(params)
      end
  end
end

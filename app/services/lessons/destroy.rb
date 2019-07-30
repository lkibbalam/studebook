# frozen_string_literal: true

module Lessons
  class Destroy
    include Callable

    def initialize(lesson:)
      @lesson = lesson
    end

    def call
      destroy_lesson
    end

    private
      attr_reader :lesson

      def destroy_lesson
        lesson.destroy
      end
  end
end

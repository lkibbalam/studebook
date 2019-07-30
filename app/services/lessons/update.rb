# frozen_string_literal: true

module Lessons
  class Update
    include Callable

    def initialize(lesson:, params:)
      @lesson = lesson
      @params = params
    end

    def call
      update_lesson
    end

    private
      attr_reader :lesson, :params

      def update_lesson
        lesson.update(params.except(:position))
        change_position if params[:position]
        lesson
      end

      def change_position
        lesson.insert_at(params[:position])
      end
  end
end

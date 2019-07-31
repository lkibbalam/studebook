# frozen_string_literal: true

module Tasks
  class Create
    include Callable

    def initialize(lesson:, params:)
      @lesson = lesson
      @params = params
    end

    def call
      create_task
    end

    private
      attr_reader :lesson, :params

      def create_task
        lesson.tasks.create(params)
      end
  end
end

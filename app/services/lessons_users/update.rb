# frozen_string_literal: true

module LessonsUsers
  class Update
    include Callable

    def initialize(lesson_user:, params:)
      @lesson_user = lesson_user
      @params = params
    end

    def call
      update_lesson_user
    end

    private
      attr_reader :lesson_user, :params

      def update_lesson_user
        lesson_user if lesson_user.update(params)
      end
  end
end

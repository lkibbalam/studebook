# frozen_string_literal: true

module LessonsUsers
  class Update
    include Callable

    def initialize(lesson_user:, params:)
      @lesson_user = lesson_user
      params.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def call
      update_lesson_user
    end

    private

    attr_reader :lesson_user, :status, :mark

    def update_lesson_user
      lesson_user if lesson_user.update(attributes)
    end

    def attributes
      { mark: mark,
        status: status }.compact
    end
  end
end

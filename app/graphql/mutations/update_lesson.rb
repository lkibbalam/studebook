# frozen_string_literal: true

module Mutations
  class UpdateLesson < Mutations::Base
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :description, String, required: false
    argument :poster, String, required: false
    argument :video, String, required: false

    field :lesson, Types::LessonType, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id:, **params)
      lesson = Lessons::Update.call(lesson: Lesson.find(id), params: params)

      {
        lesson: lesson,
        errors: user_errors(lesson.errors)
      }
    end
  end
end

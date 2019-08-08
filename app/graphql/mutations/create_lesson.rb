# frozen_string_literal: true

module Mutations
  class CreateLesson < Mutations::Base
    argument :course_id, ID, required: true
    argument :title, String, required: true
    argument :description, String, required: true
    argument :poster, String, required: false
    argument :video, String, required: false

    field :lesson, Types::LessonType, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(**params)
      lesson = Lesson.create(params)
      {
        lesson: lesson,
        errors: user_errors(lesson.errors)
      }
    end
  end
end

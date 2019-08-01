# frozen_string_literal: true

module Mutations
  class DestroyLesson < Mutations::Base
    argument :id, ID, required: true

    field :deleted, Boolean, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id:)
      lesson = Lesson.find(id)
      Lessons::Destroy.call(lesson: lesson)

      {
        deleted: lesson.destroyed?,
        errors: user_errors(lesson.errors)
      }
    end
  end
end

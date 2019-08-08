# frozen_string_literal: true

module Mutations
  class DestroyLesson < Mutations::Base
    argument :id, ID, required: true

    field :deleted, Boolean, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id:)
      lesson = Lesson.find(id)
      lesson.destroy
      {
        deleted: lesson.destroyed?,
        errors: user_errors(lesson.errors)
      }
    rescue ActiveRecord::RecordNotFound => e
      {
        deleted: false,
        errors: [UserError.new(e)]
      }
    end
  end
end

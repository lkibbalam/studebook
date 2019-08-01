# frozen_string_literal: true

module Mutations
  class DestroyCourse < Mutations::Base
    argument :id, ID, required: true

    field :deleted, Boolean, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id:)
      course = Course.find(id)
      Courses::Destroy.call(course: course)

      {
        deleted: course.destroyed?,
        errors: user_errors(course.errors)
      }
    end
  end
end

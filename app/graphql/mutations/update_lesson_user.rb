# frozen_string_literal: true

module Mutations
  class UpdateLessonUser < Mutations::Base
    argument :id, ID, required: true
    argument :status, String, required: true

    field :lesson_user, Types::LessonUserType, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id, **params)
      lesson_user = LessonsUsers::Update.call(lesson_user: LessonsUser.find(id), params: params)

      {
        lesson_user: lesson_user,
        errors: user_errors(lesson_user.errors)
      }
    end
  end
end

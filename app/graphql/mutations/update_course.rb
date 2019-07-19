# frozen_string_literal: true

module Mutations
  class UpdateCourse < Mutations::Base
    argument :team_id, ID, required: true
    argument :title, String, required: true
    argument :description, String, required: false
    argument :poster, String, required: false
    argument :team_id, ID, required: false
    argument :author_id, ID, required: false

    field :course, Types::CourseType, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id, **params)
      course = Courses::Update.call(course: Course.find(id), params: params)

      {
        course: course,
        errors: user_errors(course.errors)
      }
    end
  end
end

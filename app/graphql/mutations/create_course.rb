# frozen_string_literal: true

module Mutations
  class CreateCourse < Mutations::Base
    argument :title, String, required: true
    argument :description, String, required: true
    argument :poster, String, required: false
    argument :team_id, ID, required: false

    field :course, Types::CourseType, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(**params)
      author_id = context[:me].id
      course = Courses::Create.call(params: params.merge(author_id: author_id))

      {
        course: course,
        errors: user_errors(course.errors)
      }
    end
  end
end

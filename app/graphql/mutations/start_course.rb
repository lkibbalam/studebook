# frozen_string_literal: true

module Mutations
  class StartCourse < Mutations::Base
    argument :id, ID, required: true

    field :course_user, Types::CourseUserType, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id, **params)
      course_user = CoursesUsers::Create.call(course: Course.find(id), user: context[:me])

      {
        course_user: course_user,
        errors: user_errors(course_user.errors)
      }
    end
  end
end

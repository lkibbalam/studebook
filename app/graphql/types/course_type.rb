# frozen_string_literal: true

module Types
  class CourseType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :poster, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :team, Types::TeamType, null: true
    field :author, Types::UserType, null: false
    field :students, [Types::UserType], null: true
    field :lessons, [Types::LessonType], null: true
    field :course_user, CourseUserType, null: true

    def course_user
      current_user = context[:current_user]
      return false unless current_user
      current_user.courses_users.find_by_course_id(object.id)
    end

    def poster
      rails_blob_url(object.poster) if object.poster.attached?
    end

    def lessons
      object.lessons.with_attached_video
    end
  end
end

# frozen_string_literal: true

module Types
  class LessonType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :material, String, null: true
    field :description, String, null: true
    field :poster, String, null: true
    field :video, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :course, CourseType, null: false
    field :tasks, [TaskType], null: false
    field :lesson_user, LessonUserType, null: false

    def lesson_user
      current_user = context[:current_user]
      return false unless current_user
      current_user.lessons_users.find_by_lesson_id(object.id)
    end

    def poster
      rails_blob_url(object.poster) if object.poster.attached?
    end

    def video
      rails_blob_url(object.video) if object.video.attached?
    end
  end
end

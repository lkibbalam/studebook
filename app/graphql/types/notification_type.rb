# frozen_string_literal: true

module Types
  class NotificationType < BaseObject
    field :id, ID, null: false
    field :status, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :student, Types::UserType, null: false
    field :mentor, Types::UserType, null: false

    def student
      object.tasks_user.user
    end

    def mentor
      student.mentor
    end
  end
end

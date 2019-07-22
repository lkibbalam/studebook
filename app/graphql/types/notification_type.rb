# frozen_string_literal: true

module Types
  class NotificationType < BaseObject
    guard ->(notification, _args, ctx) { NotificationPolicy.new(ctx[:me], notification.object).show? }
    field :id, ID, null: false
    field :status, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :student, UserType, null: false
    field :mentor, UserType, null: false

    def student
      object.tasks_user.user
    end

    def mentor
      student.mentor
    end
  end
end

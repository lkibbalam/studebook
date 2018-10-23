# frozen_string_literal: true

module Types
  class TaskUserType < BaseObject
    field :id, ID, null: false
    field :status, String, null: false
    field :taks, TaskType, null: false
    field :user, UserType, null: false
    field :github_url, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

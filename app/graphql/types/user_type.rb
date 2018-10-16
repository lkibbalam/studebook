# frozen_string_literal: true

module Types
  class UserType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :email, String, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :role, String, null: false
    field :phone, String, null: true
    field :github_url, String, null: true
    field :status, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :notifications, NotificationsConnectionType, null: true
    field :mentor, Types::UserType, null: true
    field :team, Types::TeamType, null: true
  end
end

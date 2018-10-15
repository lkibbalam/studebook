# frozen_string_literal: true

module Types
  class UserType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :notifications, [Types::NotificationType], null: true
  end
end

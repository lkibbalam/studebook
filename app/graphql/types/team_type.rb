# frozen_string_literal: true

module Types
  class TeamType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :users, [Types::UserType], null: true

    def users
      object.users
    end
  end
end

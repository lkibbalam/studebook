# frozen_string_literal: true

module Types
  class TeamType < BaseObject
    field :id, ID, null: false
    field :poster, String, null: true
    field :title, String, null: false
    field :description, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :users, UsersConnectionType, null: true

    def users
      object.users
    end

    def poster
      rails_blob_url(object.poster) if object.poster.attached?
    end
  end
end

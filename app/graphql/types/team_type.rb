# frozen_string_literal: true

module Types
  class TeamType < BaseObject
    guard ->(team, _args, ctx) { TeamPolicy.new(ctx[:me], team).show? }
    field :id, ID, null: false
    field :poster, String, null: true
    field :title, String, null: false
    field :description, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :users, UsersConnectionType, null: true, extras: %i[ast_node]

    def users(ast_node:)
      Loaders::AttachmentsLoader.load_many(object, ast_node)
    end

    def poster
      rails_blob_url(object.poster) if object.poster.attached?
    end
  end
end

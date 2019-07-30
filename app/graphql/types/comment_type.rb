# frozen_string_literal: true

module Types
  class CommentType < BaseObject
    guard ->(comment, _args, ctx) { CommentPolicy.new(ctx[:me], comment.object).show? }
    field :id, ID, null: false
    field :body, String, null: false
    field :user, UserType, null: false
    field :commentable_type, String, null: false
    field :commentable_id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ancestry, String, null: true
  end
end

# frozen_string_literal: true

module Types
  class UserType < BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :avatar, String, null: true
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
    field :team, Types::TeamType, null: false
    field :padawans, UsersConnectionType, null: true
    field :comments, CommentsConnectionType, null: true

    def avatar
      rails_blob_url(object.avatar) if object.avatar.attached?
    end
  end
end

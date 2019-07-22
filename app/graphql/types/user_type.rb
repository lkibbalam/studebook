# frozen_string_literal: true

module Types
  class UserType < BaseObject
    guard ->(user, _args, ctx) { UserPolicy.new(ctx[:me], user.object).show? }
    field :id, ID, null: false
    field :email, String, null: false
    field :avatar, String, null: true
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :nickname, String, null: true
    field :role, String, null: false
    field :phone, String, null: true
    field :github_url, String, null: true
    field :status, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :notifications, NotificationsConnectionType, null: true
    field :mentor, UserType, null: true
    field :team, TeamType, null: false
    field :padawans, UsersConnectionType, null: true, extras: %i[ast_node]
    field :comments, CommentsConnectionType, null: true
    field :courses_user, CoursesUserConnectionType, null: true
    field :courses, CoursesConnectionType, null: true, extras: %i[ast_node]

    def courses_user
      object.courses_users.where(course: object.courses)
    end

    def courses(ast_node:)
      Loaders::AttachmentsLoader.load_many(object, ast_node)
    end

    def padawans(ast_node:)
      Loaders::AttachmentsLoader.load_many(object, ast_node)
    end

    def avatar
      rails_blob_url(object.avatar) if object.avatar.attached?
    end
  end
end

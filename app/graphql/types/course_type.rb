# frozen_string_literal: true

module Types
  class CourseType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :poster, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :team, Types::TeamType, null: true
    field :author, Types::UserType, null: false

    def poster
      rails_blob_url(object.poster) if object.poster.attached?
    end
  end
end

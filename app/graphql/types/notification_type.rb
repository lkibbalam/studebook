# frozen_string_literal: true

module Types
  class NotificationType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :text, String, null: false
  end
end

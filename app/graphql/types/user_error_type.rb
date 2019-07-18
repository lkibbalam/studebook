# frozen_string_literal: true

module Types
  class UserErrorType < GraphQL::Schema::Object
    graphql_name "UserError"

    field :message, String, null: false
    field :path, String, null: true
  end
end

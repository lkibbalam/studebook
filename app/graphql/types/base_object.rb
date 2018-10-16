# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    include Rails.application.routes.url_helpers
  end
end

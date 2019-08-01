# frozen_string_literal: true

module Mutations
  class DestroyUser < Mutations::Base
    argument :id, ID, required: true

    field :deleted, Boolean, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id:)
      user = User.find(id)
      Users::Destroy.call(user: user)

      {
        deleted: user.destroyed?,
        errors: user_errors(user.errors)
      }
    end
  end
end

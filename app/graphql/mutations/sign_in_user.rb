# frozen_string_literal: true

module Mutations
  class SignInUser < Mutations::Base
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(email:, password:)
      Users::SignIn.call(email: email, password: password)
    end
  end
end

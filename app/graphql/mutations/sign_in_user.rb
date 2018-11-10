# frozen_string_literal: true

module Mutations
  class SignInUser < Mutations::Base
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true

    def resolve(email:, password:)
      user = authenticate_user(email, password)
      return { errors: [UserElrror.new('email or password is invalid')] } unless user

      token = Knock::AuthToken.new(payload: { sub: user.id }).token

      {
        token: token,
        errors: []
      }
    end

    private

    def authenticate_user(email, password)
      return if email.blank? || password.blank?

      user = User.find_by(email: email)
      return unless user
      return unless user.authenticate(password)

      user
    end
  end
end

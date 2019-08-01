# frozen_string_literal: true

module Mutations
  class UpdateUser < Mutations::Base
    argument :id, ID, required: true
    argument :email, String, required: false
    argument :password, String, required: false
    argument :avatar, String, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :nickname, String, required: false
    argument :role, String, required: false
    argument :phone, String, required: false
    argument :github_url, String, required: false
    argument :status, String, required: false
    argument :mentor_id, ID, required: false
    argument :team_id, ID, required: false

    field :user, Types::UserType, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id:, **params)
      user = Users::Update.call(user: User.find(id), params: params)

      {
        user: user,
        errors: user_errors(user.errors)
      }
    end
  end
end

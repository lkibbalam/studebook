# frozen_string_literal: true

module Mutations
  class CreateUser < Mutations::Base
    argument :email, String, required: true
    argument :password, String, required: true
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

    def resolve(**params)
      user = Users::Create.call(params: params)

      {
        user: user,
        errors: user_errors(course.errors)
      }
    end
  end
end

# frozen_string_literal: true

module Mutations
  class CreateTeam < Mutations::Base
    argument :title, String, required: true
    argument :description, String, required: false

    field :team, Types::TeamType, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(**params)
      team = Teams::Create.call(params: params)

      {
        team: team,
        errors: user_errors(team.errors)
      }
    end
  end
end

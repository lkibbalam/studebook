# frozen_string_literal: true

module Mutations
  class UpdateTeam < Mutations::Base
    argument :id, ID, required: true
    argument :title, String, required: true
    argument :description, String, required: false

    field :team, Types::TeamType, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id, **params)
      team = Teams::Update.call(team: Team.find(id), params: params)

      {
        team: team,
        errors: user_errors(team.errors)
      }
    end
  end
end

# frozen_string_literal: true

module Mutations
  class DestroyTeam < Mutations::Base
    argument :id, ID, required: true

    field :deleted, Boolean, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id:)
      Teams::Destroy.call(team: Team.find(id))

      {
        deleted: task.destroyed?,
        errors: user_errors(task.errors)
      }
    end
  end
end

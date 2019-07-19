# frozen_string_literal: true

module Mutations
  class DestroyTeam < Mutations::Base
    argument :id, ID, required: true

    def resolve(id:)
      Teams::Destroy.call(team: Team.find(id))
    end
  end
end

# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :user, UserType, null: true do
      description 'Find a user by ID'
      argument :id, ID, required: true
    end
    def user(id:)
      User.find(id)
    end

    field :users, UsersConnectionType, null: false, connection: true
    def users
      User.all
    end

    field :team, TeamType, null: true do
      description 'Find team by ID'
      argument :id, ID, required: true
    end
    def team(id:)
      Team.find(id)
    end

    field :teams, TeamsConnectionType, null: true, connection: true
    def teams
      Team.all
    end
  end
end

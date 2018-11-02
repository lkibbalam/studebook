# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :me, UserType, null: true
    def me
      context[:me]
    end

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
      Team.with_attached_poster
    end

    field :course, CourseType, null: true do
      description 'Find course by ID'
      argument :id, ID, required: true
    end
    def course(id:)
      Course.find(id)
    end

    field :courses, CoursesConnectionType, null: true, connection: true, extras: %i[ast_node]
    def courses(ast_node:)
      includes = ['lessons'] if ast_node.selections.last.name == 'lessons'
      Loaders::AttachmentsLoader.load_many(nil, ast_node, includes)
    end
  end
end

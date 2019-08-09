# frozen_string_literal: true

module Mutations
  class UpdateTaskUser < Mutations::Base
    argument :id, ID, required: true
    argument :status, String, required: true, prepare: ->(status, _ctx) {
      raise GraphQL::ExecutionError.new("status cannot be blank") if status.blank?
      status
    }
    argument :github_url, String, required: true, prepare: ->(github_url, _ctx) {
      raise GraphQL::ExecutionError.new("githubUrl cannot be blank") if github_url.blank?
      github_url
    }
    argument :comment, String, required: false

    field :task_user, Types::TaskUserType, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(**params)
      task_user = TasksUser.find(params[:id])
      task_user = TasksUsers::Update.call(task_user: task_user,
                                          current_user: context[:me],
                                          params: params)

      {
        task_user: task_user,
        errors: user_errors(task_user.errors)
      }
    end
  end
end

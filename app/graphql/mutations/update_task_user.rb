# frozen_string_literal: true

module Mutations
  class UpdateTaskUser < Mutations::Base
    argument :id, ID, required: true

    field :task_user, Types::TaskUserType, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id, **params)
      task_user = TasksUser.find(id)
      task_user = TasksUsers::Update.call(task_user: task_user, current_user: context[:me], params: params)

      {
        task_user: task_user,
        errors: user_errors(task_user.errors)
      }
    end
  end
end

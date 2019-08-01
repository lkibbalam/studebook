# frozen_string_literal: true

module Types
  class TaskType < BaseObject
    guard ->(task, _args, ctx) { TaskPolicy.new(ctx[:me], task.object).show? }
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :position, Int, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :task_user, TaskUserType, null: true

    def task_user
      current_user = context[:me]
      return false unless current_user

      current_user.tasks_users.find_by_task_id(object.id)
    end
  end
end

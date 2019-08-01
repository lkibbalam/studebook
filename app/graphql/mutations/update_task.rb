# frozen_string_literal: true

module Mutations
  class UpdateTask < Mutations::Base
    argument :id, ID, required: true
    argument :title, String, required: true
    argument :description, String, required: true

    field :task, Types::TaskType, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id:, **params)
      task = Task::Update.call(lesson: Task.find(id), params: params)

      {
        task: task,
        errors: user_errors(task.errors)
      }
    end
  end
end

# frozen_string_literal: true

module Mutations
  class CreateTask < Mutations::Base
    argument :lesson_id, ID, required: true
    argument :title, String, required: true
    argument :description, String, required: true

    field :task, Types::LessonType, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(**params)
      task = Tasks::Create.call(params: params)

      {
        task: task,
        errors: user_errors(task.errors)
      }
    end
  end
end

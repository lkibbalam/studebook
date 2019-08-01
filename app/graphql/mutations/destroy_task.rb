# frozen_string_literal: true

module Mutations
  class DestroyTask < Mutations::Base
    argument :id, ID, required: true

    field :deleted, Boolean, null: true
    field :errors, [Types::UserErrorType], null: true

    def resolve(id:)
      task = Task.find(id)
      Tasks::Destroy.call(lesson: task)

      {
        deleted: task.destroyed?,
        errors: user_errors(task.errors)
      }
    end
  end
end

# frozen_string_literal: true

module Mutations
  class DestroyTask < Mutations::Base
    argument :id, ID, required: true

    def resolve(id)
      Tasks::Destroy.call(lesson: Lesson.find(id))
    end
  end
end

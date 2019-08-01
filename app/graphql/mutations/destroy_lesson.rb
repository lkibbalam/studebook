# frozen_string_literal: true

module Mutations
  class DestroyLesson < Mutations::Base
    argument :id, ID, required: true

    def resolve(id)
      Lessons::Destroy.call(lesson: Lesson.find(id))
    end
  end
end

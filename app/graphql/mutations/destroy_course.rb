# frozen_string_literal: true

module Mutations
  class DestroyCourse < Mutations::Base
    argument :id, ID, required: true

    def resolve(id)
      Courses::Destroy.call(course: Course.find(id))
    end
  end
end

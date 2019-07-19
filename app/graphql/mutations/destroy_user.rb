# frozen_string_literal: true

module Mutations
  class DestroyUser < Mutations::Base
    argument :id, ID, required: true

    def resolve(id:)
      Users::Destroy.call(user: User.find(id))
    end
  end
end

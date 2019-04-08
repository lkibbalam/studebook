# frozen_string_literal: true

module Positionable
  extend ActiveSupport::Concern

  class_methods do
    def position_increment(attr = {})
      before_create -> { position_number(attr[:scope]) }
    end
  end

  private

  def position_number(scope_name)
    scope = self.class.where("#{scope_name}": public_send(scope_name))
    self.position = (scope.maximum(:position) || 0) + 1
  end
end

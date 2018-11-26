# frozen_string_literal: true

class NotificationPolicy < ApplicationPolicy
  def update?
    return unless user&.active?

    user.admin? || user == record.tasks_user.user.mentor || user == record.tasks_user.user
  end

  class Scope < Scope
    def resolve
      return [] unless user&.active?

      scope
    end
  end
end

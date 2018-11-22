# frozen_string_literal: true

class NotificationPolicy < ApplicationPolicy
  def update?
    user.admin? || user == record.tasks_user.user.mentor || user == record.tasks_user.user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

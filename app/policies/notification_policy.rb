# frozen_string_literal: true

class NotificationPolicy < ApplicationPolicy
  def index?
    user.admin? || user == record.user
  end

  def seen?
    user.admin? || user == record.tasks_user.user.mentor || user == record.tasks_user.user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

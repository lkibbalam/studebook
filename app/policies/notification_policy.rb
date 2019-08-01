# frozen_string_literal: true

class NotificationPolicy < ApplicationPolicy
  def update?
    return unless user&.active?
    return true if user == record.user
    return true if user.staff? && user.mentor_of?(record.tasks_user.user)

    user.admin?
  end

  class Scope < Scope
    def resolve
      return [] unless user&.active?

      {
        student: scope.where(user: user),
        staff: scope.where(user: user),
        moder: scope.where(user: user),
        leader: scope.where(user: user),
        admin: scope
      }[user.role.to_sym]
    end
  end
end

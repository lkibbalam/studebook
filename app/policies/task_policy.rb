# frozen_string_literal: true

class TaskPolicy < ApplicationPolicy
  def show?
    return unless user&.active?
    return true if record&.lesson&.course&.published? || user.admin?

    (user.leader? || user.moder?) && user.team == record.lesson.course.team
  end

  def create?
    return unless user&.active?
    return true if user.admin?

    user.leader? && record.lesson.course.team == user.team
  end

  def update?
    return unless user&.active?
    return true if user.admin?

    (user.leader? || user.moder?) && record.lesson.course.team == user.team
  end

  def destroy?
    return unless user&.active?
    return true if user.admin?

    user.leader? && record.lesson.course.team == user.team
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

# frozen_string_literal: true

class LessonPolicy < ApplicationPolicy
  def show?
    return unless user&.active?
    return true if record&.course&.published? || user.admin?

    (user.leader? || user.moder?) && user.team == record.course.team
  end

  def create?
    return unless user&.active?
    return true if user.admin?

    user.leader? && record.course.team == user.team
  end

  def update?
    return unless user&.active?
    return true if user.admin?

    (user.leader? || user.moder?) && record.course.team == user.team
  end

  def destroy?
    return unless user&.active?
    return true if user.admin?

    user.leader? && record.course.team == user.team
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

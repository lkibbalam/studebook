# frozen_string_literal: true

class CoursesUserPolicy < ApplicationPolicy
  def show?
    return unless user&.active?
    return true if user == record.student || user == record.student.mentor

    user.admin? || user.leader?
  end

  def create?
    user&.active?
  end

  class Scope < Scope
    def resolve
      return [] unless user&.active?
      return scope.where(student: user) if user.student?
      return scope.where(student: user.padawans).or(scope.where(student: user)) if user.staff?
      scope.all
    end
  end
end

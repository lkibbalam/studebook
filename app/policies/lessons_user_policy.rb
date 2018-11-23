# frozen_string_literal: true

class LessonsUserPolicy < ApplicationPolicy
  def show?
    return unless user&.active?
    return true if user == record.student || user == record.student.mentor
    return true if (user.leader? || user.moder?) && user.team == record.student.team

    user.admin?
  end

  def update?
    return unless user&.active?
    return true if user == record.student || user == record.student.mentor
    return true if (user.leader? || user.moder?) && user.team == record.student.team

    user.admin? || user == record.student.mentor
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

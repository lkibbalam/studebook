# frozen_string_literal: true

class LessonsUserPolicy < ApplicationPolicy
  def show?
    return true if user.admin? || user.leader?

    (user == record.student && !record.locked?) || user == record.student.mentor
  end

  def update?
    user.admin? || user == record.student.mentor
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

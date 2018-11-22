# frozen_string_literal: true

class CoursesUserPolicy < ApplicationPolicy
  def show?
    user.admin? || user == record.student || user == record.student.mentor || user.leader?
  end

  def create
    user&.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

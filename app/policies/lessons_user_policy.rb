# frozen_string_literal: true

class LessonsUserPolicy < ApplicationPolicy
  attr_reader :record, :user

  def initializer(user, record)
    @user = user
    @record = record
  end

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

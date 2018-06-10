# frozen_string_literal: true

class LessonsUserPolicy < ApplicationPolicy
  attr_reader :record, :user

  def initializer(user, record)
    @user = user
    @record = record
  end

  def show?
    user.admin? || user == record.student || user.leader? || user == record.student.mentor
  end

  def approve_lesson?
    user.admin? || user == record.student.mentor
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

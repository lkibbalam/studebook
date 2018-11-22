# frozen_string_literal: true

class TasksUserPolicy < ApplicationPolicy
  def show?
    return true if user.admin?

    user == record.user.mentor || user == record.user
  end

  def update?
    return true if user.admin? || user == record.user && record.status == 'verifying'

    user == record.user.mentor && %w[accept change].include?(record.status)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

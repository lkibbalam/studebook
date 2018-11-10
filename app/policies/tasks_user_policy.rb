# frozen_string_literal: true

class TasksUserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    return true if user.admin?

    user == record.first.user.mentor || user == record.first.user
    # TODO: refactor something better
  end

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

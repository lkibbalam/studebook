# frozen_string_literal: true

class TaskPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initializer(user, record)
    @user = user
    @record = record
  end

  def show?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

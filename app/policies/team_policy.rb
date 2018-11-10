# frozen_string_literal: true

class TeamPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user&.active?
  end

  def show?
    user&.active?
  end

  def create?
    user&.admin?
  end

  def update?
    user&.admin?
  end

  def destroy?
    user&.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

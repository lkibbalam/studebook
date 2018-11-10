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
    return unless user&.active?

    user&.admin? || (user&.leader? && user.team == record)
  end

  def update?
    return unless user&.active?

    user.admin? || (user.moder? && record.users.exists?(user.id)) ||
      (user.leader? && user.team == record)
  end

  def destroy?
    return unless user&.active?

    user.admin? || (user.leader? && user.team == record)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

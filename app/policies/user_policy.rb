# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def current?
    return unless user&.active?
    return true if user == record

    user.staff? && user.team == record.team
  end

  def padawans?
    return unless user&.active?

    user.staff?
  end

  def show?
    return unless user&.active?
    return true if user.padawans.exists?(record.id)
    return true if user.staff? && user.team == record.team

    user.admin? || user.leader? || user == record
  end

  def mentors?
    return unless user&.active?

    user&.admin? || user&.leader?
  end

  def create?
    return unless user&.active?

    user&.admin? || user&.leader?
  end

  def update?
    return unless user&.active?

    user&.admin? || user == record
  end

  def destroy?
    return unless user&.active?

    user&.admin?
  end

  def change_password?
    return unless user&.active?

    user&.admin? || user == record
  end

  class Scope < Scope
    def resolve
      return [] unless user&.active? && !user.student?
      return scope if user.admin?
      return scope.where(mentor: user).or(scope.where(team: user.team)) if user.staff?

      User.where(team: user.team) if user.leader? || user.moder?
    end
  end
end

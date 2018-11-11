# frozen_string_literal: true

class CoursePolicy < ApplicationPolicy
  attr_reader :record, :user

  def show?
    return unless user&.active?
    return true if record&.published? || user.admin?

    (user.leader? || user.moder?) && user.team == record.team
  end

  def create?
    return unless user&.active?
    return true if user.admin?

    user.leader? && record.team == user.team
  end

  def update?
    return unless user&.active?
    return true if user.admin?

    (user.leader? || user.moder?) && record.team == user.team
  end

  def destroy?
    return unless user&.active?
    return true if user.admin?

    user.leader? && record.team == user.team
  end

  class Scope < Scope
    def resolve
      return [] unless user&.active?
      return scope if user.admin?
      return scope.where(team: user.team).or(scope.where(status: :published)) if user.leader? || user.moder?

      scope.where(status: :published)
    end
  end
end

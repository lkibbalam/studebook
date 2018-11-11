# frozen_string_literal: true

class CoursePolicy < ApplicationPolicy
  attr_reader :record, :user

  def initializer(user, record)
    super
  end

  def index?
    user&.active? && record&.published?
  end

  def show?
    user&.active? && record&.published?
  end

  def all?
    user&.active? && record&.published?
  end

  def create?
    return unless user&.active?

    user.admin? || (user.leader? && record.team == user.team)
  end

  def update?
    return unless user&.active?

    user.admin? || (user.leader? && record.team == user.team) ||
      (user.moder? && record.team == user.team)
  end

  def destroy?
    return unless user&.active?

    user.admin? || (user.leader? && record.team == user.team)
  end

  def start_course?
    user&.active? && record&.published?
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

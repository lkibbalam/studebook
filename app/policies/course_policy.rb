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
      if user.admin?
        scope.all
      elsif user.leader? && user.team == course.team
        scope.where(team: user.team)
      elsif user.moder? && user.team == ccourse.team
        scope.where(team: user.team)
      else
        scope.where(status: :published)
      end
    end
  end
end

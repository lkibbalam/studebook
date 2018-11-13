# frozen_string_literal: true

class LessonPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    user
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

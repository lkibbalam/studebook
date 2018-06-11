# frozen_string_literal: true

class CoursePolicy < ApplicationPolicy
  attr_reader :record, :user

  def initializer(user, record)
    @user = user
    @record = record
  end

  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def all?
    user.present?
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

  def start_course?
    user.present?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

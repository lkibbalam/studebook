# frozen_string_literal: true

class CoursePolicy < ApplicationPolicy
  attr_reader :record, :user

  def initializer(user, record)
    @user = user
    @record = record
  end

  def index?
    user
  end

  def show?
    user
  end

  def all?
    user
  end

  def create?
    user
  end

  def update?
    user
  end

  def destroy?
    user
  end

  def start_course?
    user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

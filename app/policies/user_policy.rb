# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def inizializer(user, record)
    @user = user
    @record = record
  end

  def current?
    user
  end

  def all?
    user.staff?
  end

  def show?
    user.admin? || user.leader? || user == record
  end

  def mentors?
    user.admin? || user.leader?
  end

  def create?
    user.admin? || user.leader?
  end

  def update?
    user.admin? || user == record
  end

  def destroy?
    user.admin?
  end

  def status?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

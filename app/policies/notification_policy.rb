# frozen_string_literal: true

class NotificationPolicy < ApplicationPolicy
  attr_reader :record, :user

  def initializer(user, record)
    @user = user
    @record = record
  end

  def index?
    user.admin? || user == record.user
  end

  def seen?
    user.admin? || user == record.tasks_user.user.mentor || user == record.tasks_user.user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

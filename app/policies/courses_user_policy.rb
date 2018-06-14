# frozen_string_literal: true

class CoursesUserPolicy < ApplicationPolicy
  attr_reader :record, :user

  def initializer(user, record)
    @user = user
    @record = record
  end

  def index?
    user.admin? || user.leader? || record.pluck(:student_id).all?(user.id)
  end

  def show?
    user.admin? || user == record.student || user == record.student.mentor || user.leader?
  end

  def padawan_courses?
    user.admin? || user.staff?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

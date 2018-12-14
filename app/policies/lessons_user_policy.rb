# frozen_string_literal: true

class LessonsUserPolicy < ApplicationPolicy
  def show?
    return unless user&.active?
    return true if user == record.student || user == record.student.mentor
    return true if (user.leader? || user.moder?) && user.team == record.student.team

    user.admin?
  end

  def update?
    return unless user&.active?
    return true if user == record.student || user == record.student.mentor
    return true if (user.leader? || user.moder?) && user.team == record.student.team

    user.admin?
  end

  class Scope < Scope
    def resolve
      return [] unless user&.active?

      {
        student: scope.where(student: user),
        staff: scope.where(student: user).or(scope.where(student: user.padawans)),
        moder: scope.joins(lesson: :course).where(student: user)
                    .or(scope.joins(lesson: :course).where(lessons: { courses: { team_id: user.team_id } })),
        leader: scope.joins(lesson: :course).where(student: user)
                     .or(scope.joins(lesson: :course).where(lessons: { courses: { team_id: user.team_id } })),
        admin: scope
      }[user.role.to_sym]
    end
  end
end

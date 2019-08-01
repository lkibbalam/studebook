# frozen_string_literal: true

class TasksUserPolicy < ApplicationPolicy
  def show?
    return unless user&.active?
    return true if user.mentor_of?(record.user) || user == record.user
    return true if (user.leader? || user.moder?) && record.task.lesson.course.team == user.team

    user.admin?
  end

  def update?
    return unless user&.active?
    return true if user.mentor_of?(record.user) || user == record.user
    return true if (user.leader? || user.moder?) && record.task.lesson.course.team == user.team

    user.admin?
  end

  class Scope < Scope
    def resolve
      return [] unless user&.active?

      {
        student: scope.where(user: user),
        staff: scope.where(user: user).or(scope.where(user: user.padawans)),
        moder: scope.joins(task: { lesson: :course }).where(user: user)
                    .or(scope.joins(task: { lesson: :course })
                    .where(tasks: { lessons: { courses: { team_id: user.team_id } } })),
        leader: scope.joins(task: { lesson: :course }).where(user: user)
                     .or(scope.joins(task: { lesson: :course })
                     .where(tasks: { lessons: { courses: { team_id: user.team_id } } })),
        admin: scope
      }[user.role.to_sym]
    end
  end
end

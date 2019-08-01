# frozen_string_literal: true

class CoursesUserPolicy < ApplicationPolicy
  def show?
    return unless user&.active?
    return true if user == record.student || user.mentor_of?(record.student)
    return true if (user.leader? || user.moder?) && user.team == record.student.team

    user.admin?
  end

  def create?
    user&.active?
  end

  class Scope < Scope
    def resolve
      return [] unless user&.active?

      # {
      #   student: scope.where(student: user),
      #   staff: scope.where(student: user.padawans).or(scope.where(student: user)),
      #   moder: scope.joins(:course).where('courses.team_id = ? OR student_id = ?', user.team_id, user.id),
      #   leader: scope.joins(:course).where('courses.team_id = ? OR student_id = ?', user.team_id, user.id),
      #   admin: scope
      # }[user.role.to_sym]

      return scope if user.admin?

      role = user.role.to_sym
      scope.joins(joins_for(role)).where(*conditions_for(role))
    end

    private
      def conditions_for(role)
        {
          staff: ["student_id IN (?) OR student_id = ?", user.padawans.select(:id), user.id],
          moder: ["courses.team_id = ? OR student_id = ?", user.team_id, user.id],
          leader: ["courses.team_id = ? OR student_id = ?", user.team_id, user.id],
          student: [student: user]
        }[role]
      end

      def joins_for(role)
        {
          moder: :course,
          leader: :course
        }[role]
      end
  end
end

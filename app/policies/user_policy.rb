# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def current?
    return unless user&.active?
    return true if user == record

    user.staff? && user.team == record.team
  end

  def padawans?
    return unless user&.active?

    user.staff?
  end

  def show?
    return unless user&.active?
    return true if user == record
    return true if user.mentor_of?(record)
    return true if (user.staff? || user.moder? || user.leader?) && user.team == record.team

    user.admin?
  end

  def mentors?
    return unless user&.active?

    user.admin? || user.leader?
  end

  def create?
    return unless user&.active?
    return true if (user.moder? || user.leader?) && user.team == record.team

    user.admin?
  end

  def update?
    return unless user&.active?
    return true if user == record
    return true if (user.moder? || user.leader?) && user.team == record.team

    user.admin?
  end

  def destroy?
    return unless user&.active?
    return true if user.leader? && user.team == record.team

    user.admin?
  end

  def change_password?
    return unless user&.active?
    return true if user == record
    return true if user.leader? && user.team == record.team

    user.admin?
  end

  def permitted_attributes
    if user.admin? || ((user.leader? || user.moder?) && user.team == record.team)
      %i[ email password first_name last_name nickname phone role avatar
          github_url mentor_id status team_id current_password new_password
          password_confirmation ]
    elsif user == record
      %i[ email first_name last_name nickname phone avatar
          github_url current_password new_password password_confirmation ]
    end
  end

  class Scope < Scope
    def resolve
      return [] unless user&.active? && !user.student?
      return scope.all if user.admin?
      scope.where(id: user.padawans).or(scope.where(team: user.team))
    end
  end
end

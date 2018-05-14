class TeamsPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    binding.pry
    user.admin?
  end
end

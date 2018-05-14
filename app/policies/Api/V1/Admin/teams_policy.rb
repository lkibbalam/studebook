class TeamsPolicy < ApplicationPolicy
  class Scopre < Scopre
    def resolve
      scope
    end
  end

  def index?
    binding.pry
    user.admin?
  end
end

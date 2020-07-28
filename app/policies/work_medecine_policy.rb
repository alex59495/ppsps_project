class WorkMedecinePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  
  def new?
    user.admin == true
  end

  def create?
    new?
  end
end

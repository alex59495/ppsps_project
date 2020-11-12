class PensionInsurancePolicy < ApplicationPolicy
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

  def show?
    true
  end

  def destroy?
    user.admin == true
  end

  def edit?
    user.admin == true
  end

  def update?
    edit?
  end
end

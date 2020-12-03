class PensionInsurancePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin
  end
  
  def new?
    user.admin
  end

  def create?
    new?
  end

  def destroy?
    user.admin
  end

  def edit?
    user.admin
  end

  def update?
    edit?
  end
end

class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
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

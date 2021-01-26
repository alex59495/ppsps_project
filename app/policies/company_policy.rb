class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.admin
  end

  def update?
    user.admin
  end

  def destroy_logo?
    user.admin
  end
end

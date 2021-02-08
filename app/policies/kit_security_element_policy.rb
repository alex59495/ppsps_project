class KitSecurityElementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.admin
  end

  def destroy?
    user.admin && user.company == record.company
  end
end

class ConductorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user)
    end
  end

  def create?
    user == record.user
  end

  def destroy?
    user == record.user
  end
end

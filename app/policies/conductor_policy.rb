class ConductorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user)
    end
  end

  def create?
    !user.nil?
  end

  def destroy?
    !user.nil?
  end
end

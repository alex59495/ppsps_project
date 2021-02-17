class WorksitePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy_plan_installation?
    !user.nil?
  end
end

class ProjectInformationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin
  end

  def create?
    user.admin
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

  def pagination?
    index?
  end
end

class SosHandPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(company: user.company)
    end
  end

  def index?
    user.admin
  end

  def create?
    user.admin
  end

  def destroyed?
    user.admin
  end

  def edit?
    user.admin
  end

  def update?
    edit?
  end
end

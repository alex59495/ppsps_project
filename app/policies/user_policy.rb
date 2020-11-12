class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user == record
  end

  def edit?
    user == record
  end

  def update?
    edit?
  end
end

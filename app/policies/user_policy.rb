class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user.company == record.company
  end

  def edit?
    user == record
  end

  def update?
    edit?
  end
end

class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.user.company.name == user.company.name
  end

  def update?
    user == record.user
  end
end

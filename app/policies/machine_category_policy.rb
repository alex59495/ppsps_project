class MachineCategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def categories?
    !user.nil?
  end
end

class SelectedSubcontractorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user == record.ppsp.user || user.admin
  end

  def destroy?
    user == record.ppsp.user || user.admin
  end
end

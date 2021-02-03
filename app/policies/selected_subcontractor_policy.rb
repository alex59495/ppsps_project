class SelectedSubcontractorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy_selected_subcontractors?
    true
  end
end

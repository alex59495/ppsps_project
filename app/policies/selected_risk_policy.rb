class SelectedRiskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy_selected_risks?
    true
  end
end

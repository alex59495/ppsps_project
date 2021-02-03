class SelectedAltitudePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy_selected_altitudes?
    true
  end
end

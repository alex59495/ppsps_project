class SelectedLifesaverPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy_selected_lifesavers?
    !user.nil?
  end
end

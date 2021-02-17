class SelectedInstallationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy_selected_installations?
    !user.nil?
  end
end

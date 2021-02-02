class AltitudeWorkPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def create?
    user.admin
  end

  def destroyed?
    user.admin
  end

  def edit?
    user.admin
  end

  def update?
    edit?
  end

  def destroy?
    true
  end

  def pagination?
    index?
  end

  def selected_altitude_works?
    true
  end
end

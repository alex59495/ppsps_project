class PpspPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.user.company.name == user.company.name
  end

  def new?
    true
  end

  def create?
    new?
  end

  def destroy?
    record.user == user
  end

  def ppsp_pdf?
    record.user.company.name == user.company.name
  end

  def update?
    record.user == user
  end

  def edit?
    record.user == user
  end

  def informations_supplementaires?
    record.user == user
  end

  def destroy_logo_client?
    record.user == user
  end

  def destroy_annexe?
    record.user == user
  end
end

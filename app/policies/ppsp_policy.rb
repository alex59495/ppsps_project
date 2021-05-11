class PpspPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def destroy?
    record.user == user
  end

  def ppsp_pdf?
    record.user.company.name == user.company.name
  end

  def update?
    true
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
    user.present?
  end

  def duplicate?
    true
  end
end

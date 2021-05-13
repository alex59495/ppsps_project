class PpspPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # Hospital_id is the last value in the Wizard form which is mandatory
      scope.includes(:user).where.not(hospital_id: nil)
    end
  end

  def show?
    record.company == user.company
  end

  def create?
    record.user == user
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
    user.present?
  end

  def duplicate?
    true
  end

  def wizard_update_end?
    record.user == user
  end

  def destroy_plan_installation?
    !user.nil?
  end
end

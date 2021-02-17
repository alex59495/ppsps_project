class SubcontractorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(company: user.company, is_destroyed: false)
    end
  end

  def index?
    user.admin
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

  def list_subcontractors?
    true
  end

  def selected_subcontractors?
    true
  end

  def destroy_selected_subcontractors?
    true
  end
end

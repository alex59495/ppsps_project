class PpspPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.user == user
  end

  def create?
    new?
  end

  def new?
    true
  end

  def ppsp_pdf?
    true
  end

  def destroy?
    record.user == user
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
end

class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.admin
  end

  def update?
    edit?
  end

  def edit?
    user.admin && user.company == record
  end

  def destroy_logo?
    user.admin && user.company == record
  end

  def edit_content_secu?
    user.admin && user.company == record
  end
end

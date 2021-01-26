class CompaniesController < ApplicationController
  before_action :find_company, only: %i[update]

  def update
    authorize @company
    if @company.update(params_company)
      redirect_to edit_profile_path(current_user)
    else
      render :edit
    end
  end

  private

  def params_company
    params.require(:company).permit(:logo)
  end

  def find_company
    @company = Company.find(params[:id])
  end
end

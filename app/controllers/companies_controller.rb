class CompaniesController < ApplicationController
  def index
    @companies = policy_scope(Company)
  end

  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new(params_company)
    authorize @company
    if @company.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  private
  def params_company
    params.require(:company).permit(:address, :name)
  end
end

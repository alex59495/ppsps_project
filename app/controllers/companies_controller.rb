class CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params_company)
    if @company.save
      redirect_to ppsp_new_path
    else
      render :new
    end
  end

  private
  def params_company
    params.require(:company).permit(:address, :name)
  end
end

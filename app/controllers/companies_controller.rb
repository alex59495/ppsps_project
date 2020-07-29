class CompaniesController < ApplicationController
  before_action :find_company, only: [ :update, :show, :destroy, :edit ]

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

  
  def edit
    authorize @company
  end

  def update
    authorize @company
    if @company.update(params_company)
      redirect_to companies_path
    else
      render :edit
    end
  end

  private
  def params_company
    params.require(:company).permit(:address, :name, :phone)
  end

  def find_company
    @company = Company.find(params[:id])
  end
end

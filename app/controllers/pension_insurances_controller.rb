class PensionInsurancesController < ApplicationController
  before_action :find_pension_insurance, only: [ :update, :show, :destroy, :edit ]

  def index
    @pension_insurances = policy_scope(PensionInsurance)
  end

  def new
    @pensions_insurance = PensionsInsurance.new
    authorize @pensions_insurance
  end

  def create
    @pensions_insurance = PensionsInsurance.new(params_pensions_insurance)
    authorize @pensions_insurance
    if @pensions_insurance.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  def edit
    authorize @pension_insurance
  end

  def update
    authorize @pension_insurance
    if @pension_insurance.update(params_pension_insurance)
      redirect_to pension_insurances_path
    else
      render :edit
    end
  end

  private
  def params_pension_insurance
    params.require(:pension_insurance).permit(:address, :phone, :fax)
  end

  def find_pension_insurance
    @pension_insurance = PensionInsurance.find(params[:id])
  end
end

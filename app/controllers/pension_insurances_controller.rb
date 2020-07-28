class PensionInsurancesController < ApplicationController
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

  private
  def params_pensions_insurance
    params.require(:pensions_insurance).permit(:address, :name, :phone)
  end
end

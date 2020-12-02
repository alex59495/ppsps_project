class PensionInsurancesController < ApplicationController
  before_action :find_pension_insurance, only: [ :update, :show, :destroy, :edit ]

  def index
    @pension_insurances = policy_scope(PensionInsurance.where(company: current_user.company))
    @pension_insurance = PensionInsurance.new
  end

  def create
    @pension_insurance = PensionInsurance.new(params_pension_insurance)
    @pension_insurance.company = current_user.company
    authorize @pension_insurance
    if @pension_insurance.save
      # Create an ordered list to use in the view 'pension_insurance/_form_field_pension_insurance'
      @pension_insurances = PensionInsurance.all.sort_by { |pension_insurance| pension_insurance.address }
      # Respond with the view pension_insurance/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_pension_insurance' }
      end
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

  def destroy
    authorize @pension_insurance
    @pension_insurance.destroy
    redirect_to pension_insurances_path
  end

  private
  def params_pension_insurance
    params.require(:pension_insurance).permit(:address, :phone, :fax, :company)
  end

  def find_pension_insurance
    @pension_insurance = PensionInsurance.find(params[:id])
  end
end

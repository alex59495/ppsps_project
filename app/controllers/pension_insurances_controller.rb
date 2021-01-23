class PensionInsurancesController < ApplicationController
  before_action :find_pension_insurance, only: %i[update show destroyed edit]

  def index
    authorize PensionInsurance
    if params[:query]
      @pension_insurances = policy_scope(PensionInsurance.search(params[:query]))
      @search = 'search'
      # We are using form_with in the index view so it respond with ajax, to handle the response we have to activate a format response
      respond_to do |format|
        # Respond with the index.js.erb
        format.js {}
      end
    else
      @pension_insurances = policy_scope(PensionInsurance.all)
      @search = 'none'
      # Must be able to respond in HTML (when load the page) and JS (when click on button Show all databse)
      respond_to do |format|
        format.html {}
        format.js {}
      end
    end

    init_infinite_loop

    @pension_insurance = PensionInsurance.new
  end

  def create
    @pension_insurance = PensionInsurance.new(params_pension_insurance)
    @pension_insurance.company = current_user.company
    authorize @pension_insurance
    if @pension_insurance.save
      # Create an ordered list to put the last one in first
      @pension_insurances = policy_scope(PensionInsurance.all).sort_by { |pension_insurance| pension_insurance.created_at }
      # Respond with the view pension_insurance/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
      # Useful for the infinite scroll, wh have to do it because we re-render the page after the action
      init_infinite_loop
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

  def destroyed
    authorize @pension_insurance
    @pension_insurance.is_destroyed = true
    if @pension_insurance.save
      redirect_to pension_insurances_path
    else
      flash.now[:error] = "L'élément n'a pas pu être supprimé"
    end
  end

  # Useful for the infinite loop
  def pagination
    if params[:query]
      @pension_insurances = policy_scope(PensionInsurance.search(params[:query]))
    else
      @pension_insurances = policy_scope(PensionInsurance.all)
    end
    authorize @pension_insurances
    @pension_insurances_page = @pension_insurances.page(params[:page])
    render 'pension_insurances/_elements', collection: @pension_insurances_page, layout: false
  end

  private

  def init_infinite_loop
    # Useful for the infinite scroll
    @pension_insurances_page = Kaminari.paginate_array(@pension_insurances).page
    @endpoint = pagination_pension_insurances_path
    @page_amount = @pension_insurances_page.total_pages
  end

  def params_pension_insurance
    params.require(:pension_insurance).permit(:address, :phone, :fax, :company)
  end

  def find_pension_insurance
    @pension_insurance = PensionInsurance.find(params[:id])
  end
end

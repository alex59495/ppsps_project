class DeminingsController < ApplicationController
  before_action :find_demining, only: [ :update, :show, :destroy, :edit ]

  def index
    @deminings = policy_scope(Demining.where(company: current_user.company))
    @demining = Demining.new
  end

  def create
    @demining = Demining.new(params_demining)
    @demining.company = current_user.company
    authorize @demining
    if @demining.save
      # Create an ordered list to use in the view 'demining/_form_field_demining'
      @deminings = Demining.all.sort_by { |demining| demining.name }
      # Respond with the view demining/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_demining' }
      end
    end
  end

  def edit
    authorize @demining
  end

  def update
    authorize @demining
    if @demining.update(params_demining)
      redirect_to deminings_path
    else
      render :edit
    end
  end

  def destroy
    authorize @demining
    @demining.destroy
    redirect_to deminings_path
  end

  private
  def params_demining
    params.require(:demining).permit(:address, :name, :phone, :company)
  end

  def find_demining
    @demining = Demining.find(params[:id])
  end
end

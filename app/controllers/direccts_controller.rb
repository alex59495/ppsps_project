class DirecctsController < ApplicationController
  before_action :find_direcct, only: [ :update, :show, :destroy, :edit ]


  def index
    @direccts = policy_scope(Direcct)
  end

  def new
    @direcct = Direcct.new
    authorize @direcct
  end

  def create
    @direcct = Direcct.new(params_direcct)
    authorize @direcct
    if @direcct.save
      # Create an ordered list to use in the view 'direcct/_form_field_direcct'
      @direccts = Direcct.all.sort_by { |direcct| direcct.address }
      # Respond with the view direcct/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_direcct' }
      end
    end
  end

  def edit
    authorize @direcct
  end

  def update
    authorize @direcct
    if @direcct.update(params_direcct)
      redirect_to direccts_path
    else
      render :edit
    end
  end

  private
  def params_direcct
    params.require(:direcct).permit(:address, :phone, :fax)
  end

  def find_direcct
    @direcct = Direcct.find(params[:id])
  end
end

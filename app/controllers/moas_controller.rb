class MoasController < ApplicationController
  before_action :find_moa, only: [ :update, :show, :destroy, :edit ]

  def index
    @moas = policy_scope(Moa)
    @moa = Moa.new
  end

  def create
    @moa = Moa.new(params_moa)
    authorize @moa
    if @moa.save
      # Create an ordered list to use in the view 'moa/_form_field_moa'
      @moas = Moa.all.sort_by { |moa| moa.name }
      # Respond with the view moa/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_moa' }
      end
    end
  end

  def edit
    authorize @moa
  end

  def update
    authorize @moa
    if @moa.update(params_moa)
      redirect_to moas_path
    else
      render :edit
    end
  end

  private
  def params_moa
    params.require(:moa).permit(:address, :name, :phone, :email, :representative)
  end

  def find_moa
    @moa = Moa.find(params[:id])
  end
end

class HospitalsController < ApplicationController
  before_action :find_hospital, only: [ :update, :show, :destroy, :edit ]

  def index
    @hospitals = policy_scope(Hospital)
  end

  def new
    @hospital = Hospital.new
    authorize @hospital
  end

  def create
    @hospital = Hospital.new(params_hospital)
    authorize @hospital
    if @hospital.save
      # Create an ordered list to use in the view 'hospital/_form_field_hospital'
      @hospitals = Hospital.all.sort_by { |hospital| hospital.name.downcase }
      # Respond with the view hospital/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_hospital' }
      end
    end
  end

  def edit
    authorize @hospital
  end

  def update
    authorize @hospital
    if @hospital.update(params_hospital)
      redirect_to hospitals_path
    else
      render :edit
    end
  end

  private
  def params_hospital
    params.require(:hospital).permit(:address, :name, :phone)
  end

  def find_hospital
    @hospital = Hospital.find(params[:id])
  end
end

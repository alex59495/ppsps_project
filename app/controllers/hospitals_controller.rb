class HospitalsController < ApplicationController
  before_action :find_hospital, only: [ :update, :show, :destroyed, :edit ]
  
  def index
    authorize Hospital
    @hospitals = policy_scope(Hospital.where(is_destroyed: false))
    @hospital = Hospital.new
  end

  def create
    @hospital = Hospital.new(params_hospital)
    @hospital.company = current_user.company
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

  def destroyed
    authorize @hospital
    @hospital.is_destroyed = true
    if @hospital.save
      redirect_to hospitals_path
    else
      flash.now[:error] = "L'élément n'a pas pu être supprimé"
    end
  end

  private
  def params_hospital
    params.require(:hospital).permit(:address, :name, :phone, :company)
  end

  def find_hospital
    @hospital = Hospital.find(params[:id])
  end
end

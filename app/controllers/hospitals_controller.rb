class HospitalsController < ApplicationController
  def new
    @hospital = Hospital.new
    authorize @hospital
  end

  def create
    @hospital = Hospital.new(params_hospital)
    authorize @hospital
    if @hospital.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  private
  def params_hospital
    params.require(:hospital).permit(:address, :name, :phone)
  end
end

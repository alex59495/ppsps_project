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
      redirect_to new_ppsp_path
    else
      render :new
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

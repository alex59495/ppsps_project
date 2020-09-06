class WorkMedecinesController < ApplicationController
  before_action :find_work_medecine, only: [ :update, :show, :destroy, :edit ]

  def index
    @work_medecines = policy_scope(WorkMedecine)
  end

  def new
    @work_medecine = WorkMedecine.new
    authorize @work_medecine
  end

  def create
    @work_medecine = WorkMedecine.new(params_work_medecine)
    authorize @work_medecine
    if @work_medecine.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  def edit
    authorize @work_medecine
  end

  def update
    authorize @work_medecine
    if @work_medecine.update(params_work_medecine)
      redirect_to work_medecines_path
    else
      render :edit
    end
  end

  private
  def params_work_medecine
    params.require(:work_medecine).permit(:address, :fax, :phone)
  end

  def find_work_medecine
    @work_medecine = WorkMedecine.find(params[:id])
  end
end

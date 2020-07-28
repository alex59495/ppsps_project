class WorkMedecinesController < ApplicationController
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

  private
  def params_work_medecine
    params.require(:work_medecine).permit(:address, :phone, :fax)
  end
end

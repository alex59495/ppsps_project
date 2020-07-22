class ProjectInformationsController < ApplicationController
  def new
    @project = ProjectInformation.new
    authorize @project
  end

  def create
    @project = ProjectInformation.new(params_project)
    authorize @project
    if @project.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  private
  def params_project
    params.require(:project).permit(:reference, :responsible, :phone, :email, :site_manager_id, :team_manager_id)
  end
end

class ProjectInformationsController < ApplicationController
  before_action :find_project_information, only: [ :update, :show, :destroy, :edit ]

  def index
    @project_informations = policy_scope(ProjectInformation)
  end

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

  def edit
    authorize @project_information
  end

  def update
    authorize @project_information
    if @project_information.update(params_project_information)
      redirect_to project_informations_path
    else
      render :edit
    end
  end

  private
  def params_project_information
    params.require(:project_information).permit(:reference, :phone, :email, :resposible, :site_manager_id, :team_manager_id)
  end

  def find_project_information
    @project_information = ProjectInformation.find(params[:id])
  end
end

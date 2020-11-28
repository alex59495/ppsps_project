class TeamManagersController < ApplicationController
  before_action :find_team_manager, only: [ :update ]

  def create
    @team_manager = TeamManager.new(params_team_manager)
    authorize @team_manager
    if @team_manager.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  def update
    authorize @team_manager
    if @team_manager.update(params_team_manager)
      redirect_to team_managers_path
    else
      render :edit
    end
  end

  private
  def params_team_manager
    params.require(:team_manager).permit(:email, :name, :phone)
  end

  def find_team_manager
    @team_manager = TeamManager.find(params[:id])
  end
end

class TeamManagersController < ApplicationController
  def index
    @team_managers = policy_scope(TeamManager)
  end
end

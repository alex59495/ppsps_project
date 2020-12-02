class ProjectInformationsController < ApplicationController

  def index
    @project_informations = policy_scope(ProjectInformation.where(company: current_user.company))
  end

end

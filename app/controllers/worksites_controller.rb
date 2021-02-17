class WorksitesController < ApplicationController
  def destroy_plan_installation
    @ppsp = Ppsp.find(params[:id])
    @ppsp.worksite.plan_installation.purge
    authorize Worksite
    respond_to do |format|
      format.js { render 'worksites/destroy_plan' }
    end
  end
end

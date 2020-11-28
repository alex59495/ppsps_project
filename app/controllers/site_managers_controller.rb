class SiteManagersController < ApplicationController
  before_action :find_site_manager, only: [ :update ]

  def create
    @site_manager = SiteManager.new(params_site_manager)
    authorize @site_manager
    if @site_manager.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end


  def update
    authorize @site_manager
    if @site_manager.update(params_site_manager)
      redirect_to site_managers_path
    else
      render :edit
    end
  end

  private
  def params_site_manager
    params.require(:site_manager).permit(:email, :name, :phone)
  end

  def find_site_manager
    @site_manager = SiteManager.find(params[:id])
  end
end

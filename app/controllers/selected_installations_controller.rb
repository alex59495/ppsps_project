class SelectedInstallationsController < ApplicationController
  before_action :find_ppsp

  def create
    #For each element from the view ppsp/informations_supplementaire which were selected
    params_selected_installation.each do |installation|
      @selected_installation = SelectedInstallation.new(site_installation_id: installation)
      @selected_installation.ppsp_id = @ppsp.id
      authorize @selected_installation
      @selected_installation.save
    end
    redirect_to informations_supplementaires_ppsp_path(@ppsp)
    # A CORRIGER CETTE PARTIE
    #   redirect_to ppsp_selected_installation_path
    # else
    #   render 'ppsp/informations_supplementaires.html.erb'
    # end
  end

  def destroy
    @selected_installation = SelectedInstallation.find(params[:id])
    authorize @selected_installation
    @selected_installation.destroy
    # Add a params to know if we are coming back to the info supp page from a destroy action
    redirect_to informations_supplementaires_ppsp_path(@ppsp, destroy: true)
  end

  private
  def params_selected_installation
    params.require(:selected_installation).require(:site_installation_id)
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:ppsp_id])
  end
end

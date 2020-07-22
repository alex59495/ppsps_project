class SelectedInstallationsController < ApplicationController

  def create
    @ppsp = Ppsp.find(params[:ppsp_id])
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

  private
  def params_selected_installation
    params.require(:selected_installation).require(:site_installation_id)
  end
end
